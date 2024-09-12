class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      log_in(user)
      redirect_to after_sign_in_path
    else
      flash.now[:alert] = 'Введите почту и пароль'
      render :new
    end
  end

  def log_out
    session.delete(:user_id)
    redirect_to login_path
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end
end
