class AddDefaultValuesToAnswersAndTests < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:tests, :level, from: nil, to: 0)

    change_column_default(:answers, :answer_body, from: nil, to: false)
  end
end
