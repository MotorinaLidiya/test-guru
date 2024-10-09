module Badges
  class PassedFirstHardTest
    def self.reward?(user, test_passage)
      return false unless test_passage.test.level >= 5 && test_passage.result_successful?

      passed_hard_test = TestPassage.joins(:test)
                                    .where(user: user, tests: { level: 5..Float::INFINITY })
                                    .select { |tp| tp.result_successful? }
                                    .first
      passed_hard_test == test_passage
    end
  end
end
