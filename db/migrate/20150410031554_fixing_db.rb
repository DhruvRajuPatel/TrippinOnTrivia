class FixingDb < ActiveRecord::Migration
  def change
    add_column :players, :challenger_player_id, :integer
    add_column :players, :challenged_player_id, :integer
    add_column :players, :challenged_score, :integer
    add_column :players, :challenged_id, :integer
  end
end
