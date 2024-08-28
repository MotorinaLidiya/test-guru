class AddCategoryToTests < ActiveRecord::Migration[6.1]
  def change
    add_reference :tests, :category, null: false, foreign_key: true
  end
end
