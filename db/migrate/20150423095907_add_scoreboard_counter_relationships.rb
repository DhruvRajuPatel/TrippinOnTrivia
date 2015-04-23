class AddScoreboardCounterRelationships < ActiveRecord::Migration
  def change
    add_column :scoreboards, :weekly_counter_id, :integer
    add_column :scoreboards, :monthly_counter_id, :integer
    add_column :scoreboards, :all_time_counter_id, :integer
    add_column :category_correct_counters, :weekly_counter_id, :integer
    add_column :category_correct_counters, :monthly_counter_id, :integer
    add_column :category_correct_counters, :all_time_counter_id, :integer
    add_column :category_correct_counters, :questions_answered, :integer
  end
end
