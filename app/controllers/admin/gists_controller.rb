class Admin::GistsController < Admin::BaseController
  before_action :authenticate_user!

  def index
    @gists = Gist.includes(:question, :user).order(created_at: :desc)
  end

  def create; end
end
