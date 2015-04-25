class AddDefaultValuesToUsers < ActiveRecord::Migration
  def change
    change_column :users, :admin, :boolean, :default => false
    change_column :users, :reviewer, :boolean, :default => false
  end
end
