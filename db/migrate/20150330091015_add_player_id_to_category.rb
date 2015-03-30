class AddPlayerIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :player_id, :integer
  end
end
