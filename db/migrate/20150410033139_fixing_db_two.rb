class FixingDbTwo < ActiveRecord::Migration
  def change
    add_column :challenges, :challenger_score, :integer
    add_column :challenges, :challenged_score, :integer
    remove_column :players, :challenged_score, :integer
    remove_column :players, :challenged_id, :integer
    add_column :players, :challenge_id, :integer
    add_column :players, :challenge_score, :integer
    add_column :challenges, :trophy_id, :integer
  end
end
