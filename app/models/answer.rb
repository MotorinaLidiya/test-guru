class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_answers_quantity

  scope :correct, -> { where(correct: true) }

  private

  def validate_answers_quantity
    return if question.blank?

    total_answers = question.answers.size
    errors.add(:question_answers, 'должно быть от 1 до 4 ответов к вопросу') unless total_answers.in?(0..3)
  end
end
