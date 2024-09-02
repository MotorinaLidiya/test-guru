class User < ApplicationRecord

  def tests_by_level(level)
    Test.joins("INNER JOIN passed_tests ON passed_tests.test_id = tests.id")
        .where("passed_tests.user_id = ? AND tests.level = ?", self.id, level)
  end
end
