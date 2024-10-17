module Badges
  class Passed3Tests
    def self.reward?(user)
      successful_tests_count = user.test_passages.includes(test: :questions).lazy.select(&:result_successful?).first(3).map(&:test_id).uniq.count
      successful_tests_count == 3
    end
  end
end
