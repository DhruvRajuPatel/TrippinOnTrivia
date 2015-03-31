class AddNextLevelThresholdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :next_level_threshold, :integer
  end
end
