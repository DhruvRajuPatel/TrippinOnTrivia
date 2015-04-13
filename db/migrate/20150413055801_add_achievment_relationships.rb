class AddAchievmentRelationships < ActiveRecord::Migration
  def change
    remove_column :users, :level
    remove_column :users, :total_correct
    add_column :users, :level, :integer, :null => false, :default => 1
    add_column :users, :total_correct, :integer, :null => false, :default => 0
    add_column :categories, :achievement_id, :integer
    add_column :achievements, :category_id, :integer
    add_column :achievements, :uid, :string
    add_column :achievements, :title, :string
    add_column :users, :achievement_id, :string
  end
end
