class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  before_action :store_path

  private

  def authenticate_user!
    unless current_user
      redirect_to login_path, alert: 'Войдите в аккаунт '
    end

    cookies[:email] = current_user&.email
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def store_path
    if request.get? && !logged_in? && request.path.present? && request.path != '/login'
      session[:forwarding_url] = request.path
    end
  end

  def after_sign_in_path
    session.delete(:forwarding_url) || root_path
  end
end
