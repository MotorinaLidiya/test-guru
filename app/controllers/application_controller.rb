class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  before_action :store_path, unless: :logged_in?

  private

  def authenticate_user!
    redirect_to login_path, alert: 'Войдите в аккаунт ' unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def store_path
    if request.get? && request.path.present? && request.path != '/login'
      cookies[:forwarding_url] = { value: request.path, expires: 1.hour.from_now }
    end
  end

  def after_sign_in_path
    cookies.delete(:forwarding_url) || root_path
  end
end
