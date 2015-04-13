class AddUserNewAchievment < ActiveRecord::Migration
  def change
    add_column :users, :has_new_achievement, :boolean, :null => false, :default => false
  end
end
