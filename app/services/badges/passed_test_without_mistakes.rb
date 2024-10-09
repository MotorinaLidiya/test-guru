module Badges
  class PassedTestWithoutMistakes
    def self.reward?(test_passage)
      test_passage.correct_questions == test_passage.test.questions.count
    end
  end
end
