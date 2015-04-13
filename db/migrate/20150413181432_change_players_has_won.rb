class ChangePlayersHasWon < ActiveRecord::Migration
  def change
    change_column :players, :has_won, :boolean, :default => false
    change_column :players, :is_inactive, :boolean, :default => false
  end
end
