class AddRemainingTimeToTestPassages < ActiveRecord::Migration[6.1]
  def change
    add_column :test_passages, :remaining_time, :integer, null: true
  end
end
