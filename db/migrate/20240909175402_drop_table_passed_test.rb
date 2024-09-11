class DropTablePassedTest < ActiveRecord::Migration[6.1]
  def up
    drop_table :passed_tests, if_exists: true
  end
end
