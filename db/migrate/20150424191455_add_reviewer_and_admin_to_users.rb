class AddReviewerAndAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :reviewer, :boolean
  end
end
