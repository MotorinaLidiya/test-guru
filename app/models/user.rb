class User < ApplicationRecord
  has_many :passed_tests, dependent: :destroy
  has_many :tests, through: :passed_tests
  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id', dependent: :nullify

  def tests_by_level(level)
    tests.where(level:)
  end
end
