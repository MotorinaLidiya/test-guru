class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.text :answer_body, null: false
      t.boolean :correct, default: false, null: false

      t.timestamps
    end
  end
end
