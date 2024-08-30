class Test < ApplicationRecord
  def self.sorted_titles(category_name)
    category = Category.find_by(title: category_name)

    Test.where(category_id: category.id).order(id: :desc)
  end
end
