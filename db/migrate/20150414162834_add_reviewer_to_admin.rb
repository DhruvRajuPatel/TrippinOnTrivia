class AddReviewerToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :reviewer, :boolean, null: false, default: false
  end
end
