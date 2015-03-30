class AddActivePlayerIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :active_player_id, :integer
  end
end
