module Badges
  class Passed3Tests
    def self.reward?(user)
      successful_tests_count = user.test_passages.select { |tp| tp.result_successful? }.map(&:test_id).uniq.count
      successful_tests_count == 3
    end
  end
end
