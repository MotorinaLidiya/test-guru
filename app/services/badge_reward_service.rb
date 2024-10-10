class BadgeRewardService
  CONDITIONS = {
    'passed_test_at_first_attempt': Badges::PassedTestAtFirstAttempt,
    'passed_test_without_mistakes': Badges::PassedTestWithoutMistakes,
    'passed_first_hard_test': Badges::PassedFirstHardTest,
    'passed_3_tests': Badges::Passed3Tests,
    'failed_3_tests': Badges::Failed3Tests
  }.freeze

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
  end

  def badge_reward
    badges_awarded = []
    badges = Badge.includes(:badge_to_users).all

    badges.each do |badge|
      if reward?(badge) && @user.badge_ids.exclude?(badge.id)
        BadgeToUser.assign_badge(@user, badge)
        badges_awarded << badge.title
      end
    end

    badges_awarded
  end

  private

  def reward?(badge)
    badge_condition = CONDITIONS[badge.condition.to_sym]
    return false unless badge_condition

    if badge_condition == Badges::Passed3Tests || badge_condition == Badges::Failed3Tests
      badge_condition.reward?(@user)
    elsif badge_condition == Badges::PassedFirstHardTest
    badge_condition.reward?(@user, @test_passage)
    else
      badge_condition.reward?(@test_passage)
    end
  end
end
