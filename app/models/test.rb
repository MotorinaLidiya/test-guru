class Test < ApplicationRecord
  INFINITY = Float::INFINITY

  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :questions, dependent: :destroy
  has_many :passed_tests, dependent: :destroy
  has_many :users, through: :passed_tests

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :easy, -> { where(level: 0..1).order(created_at: :desc) }
  scope :medium, -> { where(level: 2..4).order(created_at: :desc) }
  scope :hard, -> { where(level: 5..INFINITY).order(created_at: :desc) }

  scope :sorted_titles_by_category, lambda { |category_name|
    joins(:category)
      .where(categories: { title: category_name })
      .order(title: :desc)
      .pluck(:title)
  }
end
