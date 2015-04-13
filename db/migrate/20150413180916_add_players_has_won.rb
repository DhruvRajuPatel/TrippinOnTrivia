class AddPlayersHasWon < ActiveRecord::Migration
  def change
    add_column :players, :has_won, :boolean
    add_column :players, :is_inactive, :boolean
  end
end
