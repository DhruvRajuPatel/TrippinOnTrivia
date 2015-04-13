class CreateCategoryCorrectCounters < ActiveRecord::Migration
  def change
    create_table :category_correct_counters do |t|

      t.timestamps null: false
    end
  end
end
