class AddNullConstraints < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:tests, :title, false)
    change_column_null(:answers, :answer_body, false)
    change_column_null(:categories, :category_title, false)
    change_column_null(:questions, :question_body, false)
    change_column_null(:users, :name, false)
    change_column_null(:users, :role, false)
  end
end
