class AddPlayerIdToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :player_id, :integer
  end
end
