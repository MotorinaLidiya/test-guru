class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.text :question_body
      t.references :test, null: false, foreign_key: true

      t.timestamps
    end
  end
end
