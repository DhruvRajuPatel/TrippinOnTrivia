class TheBigOne < ActiveRecord::Migration
  def change
    remove_column :users, :next_level_threshold
    add_column :challenges, :question_counter, :integer
    add_column :players, :challenger_player_id, :integer
    add_column :players, :challenged_player_id, :integer
    add_column :players, :winner_player_id, :integer
    add_column :trophies, :bid_trophy_id, :integer
    add_column :trophies, :challenged_trophy_id, :integer
    add_column :players, :challenge_score, :integer
    add_column :challenges, :challenger_score, :integer
    add_column :challenges, :challenged_score, :integer
  end
end
