class CreateLossKeepers < ActiveRecord::Migration
  def change
    create_table :loss_keepers do |t|

      t.timestamps null: false
    end
  end
end
