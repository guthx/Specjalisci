class MessagesController < ApplicationController

  def new
    @message = Message.new()
    @receiver = User.find(params[:receiver_id])
  end

  def create
    @message = Message.new(review_params)

    respond_to do |format|
      if @message.save
        n = Notification.where(user_id: @message.receiver_id, notification_type: 'message', seen: false)
        if n.exists?
          n[0].count = n[0].count + 1
          n[0].save
        else
          n1 = Notification.create(user_id: @message.receiver_id, specialist_id: Specialist.first.id, notification_type: 'message', seen: false, count: 1)
        end
        format.js
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @message = Message.find(params[:id])
    if current_user.id == @message.receiver_id
      @message.seen = true
      @message.save
    end
  end


  def review_params
    params.require(:message).permit(:sender_id, :receiver_id, :topic, :message)
  end
end
