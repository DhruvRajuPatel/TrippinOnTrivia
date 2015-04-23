class CreateLossKeepersPlayers < ActiveRecord::Migration
  def self.up
    create_table :loss_keepers_players, :id => false do |t|
      t.integer :loss_keeper_id
      t.integer :player_id
    end
  end

  def self.down
    drop_table :loss_keepers_players
  end
end
