class AddUserKeeperAssociations < ActiveRecord::Migration
  def change
    add_column :users, :win_keeper_id, :integer
    add_column :users, :loss_keeper_id, :integer
    add_column :win_keepers, :uid, :string
    add_column :loss_keepers, :uid, :string
  end
end
