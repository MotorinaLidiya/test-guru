class User < ApplicationRecord
  def tests_by_level(level)
    Test.where(level:).distinct
  end
end
