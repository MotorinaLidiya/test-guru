class Admin::GistsController < Admin::BaseController
  before_action :authenticate_user!

  def index
    @gists = Gist.includes(:question, :user).order(created_at: :desc)
  end

  def create
    test_passage = TestPassage.find(params[:test_passage_id])
    result = GistQuestionService.new(test_passage).call

    if result.success?
      flash[:notice] = t('.success_html', url: result.value![:html_url])
    else
      flash[:alert] = t('.failure')
    end

    redirect_to test_passage
  end

  private

  def gist_params
    params.require(:gist).permit(:test_passage_id)
  end
end
