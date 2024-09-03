class Question < ApplicationRecord
  belongs_to :test

  has_many :answers, dependent: :destroy

  validates :body, presence: true
  validate :validate_answers_quantity, if: :persisted?

  def correct_answer
    answers.correct
  end

  private

  def validate_answers_quantity
    total_answers = answers.size
    errors.add(:answers, 'Количество ответов должно быть от 1 до 4.') if total_answers < 1 || total_answers > 4
  end
end
