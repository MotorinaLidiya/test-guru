class BadgeToUser < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  def self.assign_badge(user, badge)
    BadgeToUser.find_or_create_by(user_id: user.id, badge_id: badge.id)
  end
end
