module Badges
  class Failed3Tests
    def self.reward?(user)
      failed_tests_count = user.test_passages.select { |tp| !tp.result_successful? }.map(&:test_id).uniq.count
      failed_tests_count == 3
    end
  end
end
