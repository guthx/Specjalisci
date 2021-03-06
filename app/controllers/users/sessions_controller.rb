# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def mySpecialists
    if !user_signed_in?
      redirect_to 'users/sign_in'
    end
    if params[:notified] != nil
      @notified = params[:notified]
      n = Notification.find(params[:n_id])
      if n.seen == false
        n.seen = true
        n.save
      end
    end
  end

  def myMessages
    if !user_signed_in?
      redirect_to 'users/sign_in'
    end
    if params[:redirect] != nil
      if params[:redirect] == 'send'
        @redirect = 'send'
        @receiver = params[:id]
      end
      if params[:redirect] == 'notification'
        @redirect = 'notification'
        n = Notification.find(params[:n_id])
        n.seen = true
        n.save
      end
    end
  end

  def sentMessages
    @messages = current_user.messages_sent
  end

  def receivedMessages
    @messages = current_user.messages_received
  end

end
