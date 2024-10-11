class AddIndexesToBadges < ActiveRecord::Migration[6.1]
  def change
    add_index :badges, :title, unique: true
    add_index :badges, :description, unique: true
  end
end
