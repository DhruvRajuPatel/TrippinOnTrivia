class AddBackStuff < ActiveRecord::Migration
  def change
    add_column :category_correct_counters, :aquatic_counter_id, :integer
    add_column :category_correct_counters, :memes_counter_id, :integer
    add_column :category_correct_counters, :basketball_counter_id, :integer
    add_column :category_correct_counters, :literature_counter_id, :integer
    add_column :category_correct_counters, :music_counter_id, :integer
    add_column :category_correct_counters, :cs_counter_id, :integer
    add_column :users, :aquatic_counter_id, :integer
    add_column :users, :memes_counter_id, :integer
    add_column :users, :basketball_counter_id, :integer
    add_column :users, :literature_counter_id, :integer
    add_column :users, :music_counter_id, :integer
    add_column :users, :cs_counter_id, :integer
  end
end
