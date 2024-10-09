class BadgeRewardService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
  end

  def badge_reward
    badges_awarded = []
    badges = Badge.includes(:badge_to_users).all

    badges.each do |badge|
      if badge.reward?(@test_passage, @user) && @user.badge_ids.exclude?(badge.id)
        BadgeToUser.assign_badge(@user, badge)
        badges_awarded << badge.title
      end
    end

    badges_awarded
  end
end
