class AddWinCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :win_count, :integer, :default => 0
  end
end
