class AddSearchableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :searchable, :boolean, null: false, default: true
  end
end
