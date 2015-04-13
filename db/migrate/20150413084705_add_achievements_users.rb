class AddAchievementsUsers < ActiveRecord::Migration
  def change
    def self.up
      create_table :achievements_users, :id => false do |t|
        t.integer :category_id
        t.string :uid
      end
    end

    def self.down
      drop_table :achievements_users
    end
  end
end
