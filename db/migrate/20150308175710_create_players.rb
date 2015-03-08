class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :meter

      t.timestamps null: false
    end
  end
end
