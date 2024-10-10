module Badges
  class PassedTestAtFirstAttempt
    def self.reward?(test_passage)
      test_passage.user.test_passages.where(test: test_passage.test).count == 1 && test_passage.result_successful?
    end
  end
end
