class CreateWinKeepers < ActiveRecord::Migration
  def change
    create_table :win_keepers do |t|

      t.timestamps null: false
    end
  end
end
