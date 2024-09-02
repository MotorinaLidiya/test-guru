class User < ApplicationRecord
  has_many :passed_tests
  has_many :tests, through: :passed_tests
  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id'

  def tests_by_level(level)
    Test.joins(:passed_tests)
      .where(passed_tests: { user_id: id }, level:)
  end
end
