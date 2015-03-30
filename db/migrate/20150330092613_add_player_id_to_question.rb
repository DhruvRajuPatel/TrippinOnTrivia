class AddPlayerIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :player_id, :integer
  end
end
