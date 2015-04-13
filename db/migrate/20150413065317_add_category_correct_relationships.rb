class AddCategoryCorrectRelationships < ActiveRecord::Migration
  def change
    add_column :category_correct_counters, :uid, :string
    add_column :categories, :category_correct_counter_id, :integer
    add_column :category_correct_counters, :category_id, :integer
    add_column :users, :aquatic_counter_id, :integer
    add_column :users, :memes_counter_id, :integer
    add_column :users, :basketball_counter_id, :integer
    add_column :users, :literature_counter_id, :integer
    add_column :users, :music_counter_id, :integer
    add_column :users, :cs_counter_id, :integer
  end
end
