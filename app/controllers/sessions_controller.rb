class SessionsController < Devise::SessionsController
  def create
    super
    unless current_user.is_a?(Admin)
      flash[:notice] = "Привет, #{current_user.last_name.presence || 'Гуру'} #{current_user.first_name.presence || ''}!".strip
    end
  end
end
