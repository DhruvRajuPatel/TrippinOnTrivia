class ChangeIsActivePlayerNamePlayers < ActiveRecord::Migration
  def change
      rename_column :players, :isActivePlayer, :is_current_turn
  end
end
