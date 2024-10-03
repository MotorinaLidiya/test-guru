class GistsController < ApplicationController
  before_action :authenticate_user!

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

