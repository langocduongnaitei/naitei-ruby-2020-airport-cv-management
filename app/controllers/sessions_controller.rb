class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email]
    authenticate_handle user
  end

  private

  def authenticate_handle user
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.user.checkbox_value ? remember(user) : forget(user)
      redirect_to user
    else
      flash[:danger] = t "sessions.new.error_message"
      render :new
    end
  end
end
