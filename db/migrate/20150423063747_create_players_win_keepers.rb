class CreatePlayersWinKeepers < ActiveRecord::Migration
  def self.up
    create_table :players_win_keepers, :id => false do |t|
      t.integer :player_id
      t.integer :win_keeper_id
    end
  end

  def self.down
    drop_table :players_win_keepers
  end
end
