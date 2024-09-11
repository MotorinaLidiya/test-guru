class AddPasswordDigestToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_digest, :string, null: false

    change_column_null :users, :email, false
  end
end
