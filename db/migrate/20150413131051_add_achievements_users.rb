class AddAchievementsUsers < ActiveRecord::Migration
  def self.up
    create_table :achievements_users, :id => false do |t|
      t.integer :achievement_id
      t.string :uid
    end
  end

  def self.down
    drop_table :achievements_users
  end
end
