class AddTrophyIconToTrophies < ActiveRecord::Migration
  def change
    add_column :trophies, :icon_path, :string
  end
end
