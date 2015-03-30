class AddPlayerIdToUserId < ActiveRecord::Migration
  def change
    add_column :users, :player_id, :integer
  end
end
