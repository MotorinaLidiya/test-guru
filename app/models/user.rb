class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages

  has_many :gists, dependent: :destroy

  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id', dependent: :destroy, inverse_of: :author

  has_many :badge_to_users, dependent: :destroy
  has_many :badges, through: :badge_to_users

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  # rubocop:disable Rails/Delegate
  def tests_by_level(level)
    tests.by_level(level)
  end
  # rubocop:enable Rails/Delegate
end
