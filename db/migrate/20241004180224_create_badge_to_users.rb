class CreateBadgeToUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :badge_to_users do |t|
      t.references :user, null: false, foreign_key: true, unique: true
      t.references :badge, null: false, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
