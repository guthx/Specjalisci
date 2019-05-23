class SpecialistsController < ApplicationController
  before_action :set_specialist, only: [:show, :edit, :update, :destroy]

  # GET /specialists
  # GET /specialists.json
  def index
    @specialists = Specialist.all
  end

  # GET /specialists/1
  # GET /specialists/1.json
  def show
  end

  # GET /specialists/new
  def new
    @specialist = Specialist.new
    if params[:foreign] == 'true'
      @foreign = true
    else
      @foreign = false
    end
  end

  # GET /specialists/1/edit
  def edit
  end

  # POST /specialists
  # POST /specialists.json
  def create
    if params[:foreign] == false
      @specialist = Specialist.new(specialist_params)
      if @specialist.email == current_user.email
        @specialist.confirmation_code = nil
        @specialist.confirmed = true
      else
        @specialist.confirmation_code = SecureRandom.base64(10)
        @specialist.confirmed = false
      end
      respond_to do |format|
        if @specialist.save
          if @specialist.confirmed == false
            UserMailer.confirm(@specialist).deliver_now
            format.html { redirect_to '/specialist_created?confirmed=false' }
          else
            format.html { redirect_to '/specialist_created?confirmed=true' }
          end
        else
          format.html { render :new }
          format.json { render json: @specialist.errors, status: :unprocessable_entity }
        end
      end
    else
      @specialist = Specialist.new(specialist_params)
      if @specialist.email == current_user.email
        flash[:error] = "Nie można dodać cudzej działalności pod własnym adresem e-mail!"
        @foreign = true
        render :new
      else
        @specialist.confirmation_code = SecureRandom.base64(10)
        @specialist.confirmed = false
        respond_to do |format|
          if @specialist.save
            UserMailer.confirm_foreign(@specialist).deliver_now
            format.html { redirect_to '/specialist_created?confirmed=foreign' }
          else
            format.html { render :new }
            format.json { render json: @specialist.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PATCH/PUT /specialists/1
  # PATCH/PUT /specialists/1.json
  def update
    respond_to do |format|
      if @specialist.update(specialist_params)
        format.html { redirect_to @specialist, notice: 'Specialist was successfully updated.' }
        format.json { render :show, status: :ok, location: @specialist }
      else
        format.html { render :edit }
        format.json { render json: @specialist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specialists/1
  # DELETE /specialists/1.json
  def destroy
    @specialist.destroy
    respond_to do |format|
      format.html { redirect_to specialists_url, notice: 'Specialist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def find
    @coordx = params[:coordx]
    @coordy = params[:coordy]
    @specialty_id = params[:specialty_id]
  end

  def findJSON
    specialists = Specialist.where(specialty_id: params[:id]).where(confirmed: true)
    info = []
    specialists.each do |specialist|
      info << {first_name: specialist.first_name, last_name: specialist.last_name, coordx: specialist.coordx, coordy: specialist.coordy, id: specialist.id, city: specialist.city, street: specialist.street, rating: specialist.rating}
    end
    respond_to do |format|
      format.json { render json: info }
    end
  end

  def getReviews
    specialist = Specialist.find(params[:id])
    reviews = []
    specialist.reviews.each do |review|
      reviews << {rating: review.rating, text: review.text, userName: review.user.full_name}
    end
    respond_to do |format|
      format.json { render json: reviews }
    end
  end

  def confirm
    specialist = Specialist.find(params[:id])
    if (specialist.confirmation_code == params[:confirmation_code]) && (specialist.confirmed == false)
      specialist.confirmed = true
      specialist.save
    else
      redirect_to '/link_expired'
    end
  end

  def details
    @specialist = Specialist.find(params[:id])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_specialist
      @specialist = Specialist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def specialist_params
      params.require(:specialist).permit(:first_name, :last_name, :company_name, :city, :street, :coordx, :coordy, :specialty_id, :user_id, :phone, :email, :additional_info)
    end
end
