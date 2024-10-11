class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[new create]

  def new
    @feedback = Feedback.new
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.name = current_user.name || current_user.email

    @test = Test.find(feedback_params[:test_id])
    @feedback.author_email = @test_passage.test.author.email

    if @feedback.save
      UserMailer.feedback_email(@feedback, @test).deliver_now
      redirect_to tests_path, notice: t('.success')
    else
      render :new
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:test_passage_id])
  end

  def feedback_params
    params.require(:feedback).permit(:message, :test_id)
  end
end
