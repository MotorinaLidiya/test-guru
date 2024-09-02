class Test < ApplicationRecord
  belongs_to :category

  def self.sorted_titles_by_category(category_name)
    joins("INNER JOIN categories ON categories.id = tests.category_id")
      .where("categories.title = ?", category_name)
      .order(title: :desc)
      .pluck(:title)
  end
end
