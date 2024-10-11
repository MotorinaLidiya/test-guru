class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result]

  def show
    @test_passage = current_user.test_passages.find(params[:id])
  end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      awarded_badges = reward_badges
      flash[:notice] = t('.badges_awarded', badges: awarded_badges.join(', ')) if awarded_badges.present?

      TestsMailer.completed_test(@test_passage).deliver_now if @test_passage.result_successful?

      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  private

  def reward_badges
    BadgeRewardService.new(@test_passage).badge_reward
  end

  def set_test_passage
    @test_passage = TestPassage.includes(test: { questions: :answers }).find(params[:id])
  end
end
