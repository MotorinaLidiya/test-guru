class Admin::GistsController < Admin::BaseController
  def index
    @gists = Gist.includes(:question, :user).order(created_at: :desc)
  end

  def create; end
end
