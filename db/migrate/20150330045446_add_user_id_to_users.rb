class AddUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :players, :uid, :string
    add_index :players, :uid
  end
end
