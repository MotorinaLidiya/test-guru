class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.string :name, null: false
      t.string :author_email, null: false
      t.text :message, null: false
      t.references :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
