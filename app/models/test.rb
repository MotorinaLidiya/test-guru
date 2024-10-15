class Test < ApplicationRecord
  INFINITY = Float::INFINITY
  TIMER = /\A([0-5][0-9]|[0-9]):([0-5][0-9])\z/

  attr_accessor :questions_cached_count

  belongs_to :category
  belongs_to :author, class_name: 'User', inverse_of: :tests

  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages
  has_many :feedbacks, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :level, message: I18n.t('tests.test_level_exists') }
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :duration, allow_blank: true, format: { with: TIMER, message: I18n.t('tests.test_timer_format') }

  scope :easy, -> { where(level: 0..1).order(created_at: :desc) }
  scope :medium, -> { where(level: 2..4).order(created_at: :desc) }
  scope :hard, -> { where(level: 5..INFINITY).order(created_at: :desc) }
  scope :by_level, ->(level) { where(level:).order(title: :desc) }

  scope :by_category, lambda { |category_name|
    joins(:category)
      .where(categories: { title: category_name })
      .order(title: :desc)
  }

  def self.titles_by_category(category_name)
    by_category(category_name).pluck(:title)
  end
end
