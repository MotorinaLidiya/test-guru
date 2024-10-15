class AddTimerToTests < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :duration, :string, null: true
  end
end
