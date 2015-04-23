class AddPrivacyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hide_image, :boolean, null: false, default: false
  end
end
