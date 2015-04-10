class TheBigOne < ActiveRecord::Migration
  def change
    remove_column :users, :next_level_threshold
    add_column :challenges, :question_counter, :integer
    add_column :challenges, :challenger_player_id, :integer
    add_column :challenges, :challenged_player_id, :integer
    add_column :challenges, :winner_player_id, :integer
    add_column :challenges, :question_id, :integer
    add_column :challenges, :answer_id, :integer
    add_column :answers, :challenge_id, :integer
    add_column :questions, :challenge_id, :integer
  end
end
