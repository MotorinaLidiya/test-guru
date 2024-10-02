class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
    @test_passage = TestPassage.find(params[:test_passage_id])
    @test = @test_passage.test
  end

  def create
    @test_passage = TestPassage.find(params[:test_passage_id])
    @feedback = Feedback.new(feedback_params)
    @feedback.name = current_user.name || current_user.email

    @test = Test.find(feedback_params[:test_id])
    @feedback.author_email = @test.author.email

    if @feedback.save
      UserMailer.feedback_email(@feedback, @test).deliver_now
      redirect_to tests_path, notice: t('.success')
    else
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:message, :test_id)
  end
end
