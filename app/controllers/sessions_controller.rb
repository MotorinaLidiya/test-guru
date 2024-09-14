class SessionsController < Devise::SessionsController
  def create
    super do |user|
      flash[:notice] = "Привет, #{user.last_name} #{user.first_name}!" unless user.is_a?(Admin)
    end
  end
end
