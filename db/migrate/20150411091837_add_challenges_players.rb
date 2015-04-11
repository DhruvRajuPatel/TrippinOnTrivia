class AddChallengesPlayers < ActiveRecord::Migration
  def self.up
    create_table :challenges_players, :id => false do |t|
      t.integer :player_id
      t.integer :challenge_id
    end
  end

  def self.down
    drop_table :challenges_players
  end
end
