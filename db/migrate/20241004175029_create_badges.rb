class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :title, null: false
      t.string :condition, null: false
      t.string :description, null: false
      t.string :image_url, null: false


      t.timestamps
    end
  end
end
