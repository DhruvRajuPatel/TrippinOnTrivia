class RemoveAchievementsUsers < ActiveRecord::Migration
  def change
    drop_table :achievements_users
  end
end
