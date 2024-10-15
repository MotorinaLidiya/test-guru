module Badges
  class Failed3Tests
    def self.reward?(user)
      failed_tests_count = user.test_passages.includes(test: :questions).lazy.reject(&:result_successful?).first(3).map(&:test_id).uniq.count
      failed_tests_count == 3
    end
  end
end
