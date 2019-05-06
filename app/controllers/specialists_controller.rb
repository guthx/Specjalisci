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
  end

  # GET /specialists/1/edit
  def edit
  end

  # POST /specialists
  # POST /specialists.json
  def create
    @specialist = Specialist.new(specialist_params)

    respond_to do |format|
      if @specialist.save
        format.html { redirect_to @specialist, notice: 'Specialist was successfully created.' }
        format.json { render :show, status: :created, location: @specialist }
      else
        format.html { render :new }
        format.json { render json: @specialist.errors, status: :unprocessable_entity }
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
    specialists = Specialist.where(specialty_id: params[:id])
    info = []
    specialists.each do |specialist|
      info << {first_name: specialist.first_name, last_name: specialist.last_name, coordx: specialist.coordx, coordy: specialist.coordy}
    end
    respond_to do |format|
      format.json { render json: info }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_specialist
      @specialist = Specialist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def specialist_params
      params.require(:specialist).permit(:first_name, :last_name, :company_name, :city, :street, :coordx, :coordy, :specialty_id, :user_id)
    end
end
