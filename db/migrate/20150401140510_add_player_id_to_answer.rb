class AddPlayerIdToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :player_id, :integer
  end
end
