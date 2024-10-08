class Badge < ApplicationRecord

  has_many :badge_to_users, dependent: :destroy
  has_many :users, through: :badge_to_users

  validates :title, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :description, presence: true, length: { maximum: 60 }, uniqueness: true
  validates :condition, presence: true
  validates :image_url, presence: true

  def reward?(test_passage, user)
    case condition
    when 'passed_test_at_first_attempt'
      passed_test_at_first_attempt?(test_passage)
    when 'passed_test_without_mistakes'
      passed_test_without_mistakes?(test_passage)
    when 'passed_first_hard_test'
      passed_first_hard_test?(user, test_passage)
    when 'passed_3_tests'
      passed_3_tests?(user)
    when 'failed_3_tests'
      failed_3_tests?(user)
    end
  end

  private

  def passed_test_at_first_attempt?(test_passage)
    test_passages = TestPassage.where(user: test_passage.user, test: test_passage.test)

    test_passages.count == 1 && test_passage.result_successful?
  end

  def passed_test_without_mistakes?(test_passage)
    test_passage.correct_questions == test_passage.test.questions.count
  end

  def passed_first_hard_test?(user, test_passage)
    return false unless test_passage.test.level >= 5 && test_passage.result_successful?

    passed_hard_test = TestPassage.joins(:test)
                                         .where(user: user, tests: { level: 5..Float::INFINITY })
                                         .select { |tp| tp.result_successful? }
                                         .first

    passed_hard_test == test_passage
  end

  def passed_3_tests?(user)
    successful_tests_count = user.test_passages.select { |tp| tp.result_successful? }.map(&:test_id).uniq.count

    successful_tests_count == 3
  end


  def failed_3_tests?(user)
    failed_tests_count = user.test_passages.select { |tp| !tp.result_successful? }.map(&:test_id).uniq.count

    failed_tests_count == 3
  end
end
