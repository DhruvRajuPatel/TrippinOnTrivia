class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :meter
      t.boolean  "isActivePlayer"
      t.integer  "player_id"
      t.timestamps null: false
    end
  end
end
