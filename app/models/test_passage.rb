class TestPassage < ApplicationRecord
  SUCCESS_RATIO = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :set_current_question

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end

    save!
  end

  def current_question_number
    return test.questions.size if current_question.nil?

    test.questions.order(:id).index(current_question) + 1
  end

  def result_count
    total_questions = test.questions.size

    (correct_questions.to_f / total_questions * 100).round
  end

  def result_message
    percent = result_count
    if percent >= SUCCESS_RATIO
      "#{percent}% Тест успешно пройден."
    else
      "#{percent}% Тест не пройден."
    end
  end

  def result_successful?
    result_count >= SUCCESS_RATIO
  end

  private

  def set_current_question
    if new_record?
      self.current_question = test.questions.first
    else
      self.current_question = next_question
    end
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
end
