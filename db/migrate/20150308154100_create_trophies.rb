class CreateTrophies < ActiveRecord::Migration
  def change
    create_table :trophies do |t|

      t.references :category, index: true

      t.timestamps null: false
    end
  end
end
