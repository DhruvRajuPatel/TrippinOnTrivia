class AddIsFirstRoundToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :is_first_round, :boolean
  end
end
