class BadgesController < ApplicationController
  before_action :authenticate_user!

  def index
    @badges = Badge.order(created_at: :desc)
  end

  def my
    @badges = current_user.badges
  end
end
