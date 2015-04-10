class GenerateChallengeTrophyRelations < ActiveRecord::Migration
  def change
    add_column :trophies, :challenged_trophy_id, :integer
    add_column :trophies, :bid_trophy_id, :integer
    add_column :challenges, :challenged_trophy_id, :integer
    add_column :challenges, :bid_trophy_id, :integer
  end
end
