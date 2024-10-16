class TestPassage < ApplicationRecord
  SUCCESS_RATIO = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :set_current_question, unless: -> { remaining_time_changed? }

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    return set_current_question if time_over?

    self.correct_questions += 1 if correct_answer?(answer_ids) && current_question.answers.any?
    save!
  end

  def current_question_number
    return test.questions.size if current_question.nil?

    test.questions.order(:id).index(current_question) + 1
  end

  def result_rate
    return @rate if @rate

    @rate = calculate_rate
  end

  def result_message
    percent = result_rate
    if percent >= SUCCESS_RATIO
      I18n.t('test_passages.result.success', percent:)
    else
      I18n.t('test_passages.result.fail', percent:)
    end
  end

  def result_successful?
    result_rate >= SUCCESS_RATIO
  end

  def test_completion_time
    return nil if test.nil? || test.duration.nil?

    created_at + test.duration
  end

  def time_over?
    return false if completed?

    remaining_time&.zero?
  end

  def formatted_remaining_time
    minutes = (remaining_time / 60).floor
    seconds = (remaining_time % 60).round

    "#{minutes}:#{seconds.to_s.rjust(2, '0')}"
  end

  private

  def set_current_question
    self.current_question = new_record? ? test.questions.first : next_question
  end

  def set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.to_a.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def calculate_rate
    count = questions_cached_count
    return 0 if count.zero?

    (correct_questions.to_f / count * 100).round
  end

  def questions_cached_count
    test.questions_cached_count ||= test.questions.joins(:answers).distinct.count
  end
end
