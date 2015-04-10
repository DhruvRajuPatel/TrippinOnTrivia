class TheBigOne < ActiveRecord::Migration
  def change
    remove_column :users, :next_level_threshold
    add_column :challenges, :question_counter, :integer
    add_column :challenges, :challenger_player_id, :integer
    add_column :challenges, :challenged_player_id, :integer
    add_column :challenges, :winner_player_id, :integer
  end
end
