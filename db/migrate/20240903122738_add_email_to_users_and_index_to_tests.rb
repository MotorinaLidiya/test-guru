class AddEmailToUsersAndIndexToTests < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email, :string

    add_index :tests, [:title, :level], unique: true
  end
end
