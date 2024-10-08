class AddNameAndTypeAttributesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :type, :string, null: false, default: 'User'
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_index :users, :type

    change_column_null :users, :name, true

    remove_column :users, :role
  end
end
