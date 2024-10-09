class Badge < ApplicationRecord

  has_many :badge_to_users, dependent: :destroy
  has_many :users, through: :badge_to_users

  validates :title, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :description, presence: true, length: { maximum: 60 }, uniqueness: true
  validates :condition, presence: true
  validates :image_url, presence: true

  def reward?(test_passage, user)
    case condition
    when 'passed_test_at_first_attempt'
      Badges::PassedTestAtFirstAttempt.reward?(test_passage)
    when 'passed_test_without_mistakes'
      Badges::PassedTestWithoutMistakes.reward?(test_passage)
    when 'passed_first_hard_test'
      Badges::PassedFirstHardTest.reward?(user, test_passage)
    when 'passed_3_tests'
      Badges::Passed3Tests.reward?(user)
    when 'failed_3_tests'
      Badges::Failed3Tests.reward?(user)
    end
  end
end
