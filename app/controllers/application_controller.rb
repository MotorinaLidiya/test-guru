class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(user)
    flash[:notice] = "Привет, #{user.last_name} #{user.first_name}!"
    return super unless user.is_a?(Admin)

    admin_tests_path
  end
end
