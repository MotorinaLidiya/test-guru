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
  has_many :gists
  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id', dependent: :destroy

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def tests_by_level(level)
    tests.by_level(level)
  end
end
