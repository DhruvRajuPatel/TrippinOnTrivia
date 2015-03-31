class AddTotalCorrectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_correct, :integer
  end
end
