class AddTrophiesPlayers < ActiveRecord::Migration
  def self.up
    create_table :players_trophies, :id => false do |t|
      t.integer :player_id
      t.integer :trophy_id
    end
  end

  def self.down
    drop_table :players_trophies
  end
end
