class AddMutedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :muted, :boolean, null: false, default: false
  end
end