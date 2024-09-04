class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_answers_quantity, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def validate_answers_quantity
    total_answers = question.answers.count
    errors.add(:question_answers, 'должно быть от 1 до 4 ответов к вопросу') if total_answers >= 4
  end
end
