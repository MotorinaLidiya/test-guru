class Test < ApplicationRecord
  belongs_to :category
  has_many :passed_tests
  has_many :users, through: :passed_tests

  def self.sorted_titles_by_category(category_name)
    joins(:category).where(categories: { title: category_name }).order(title: :desc).pluck(:title)
  end
end
