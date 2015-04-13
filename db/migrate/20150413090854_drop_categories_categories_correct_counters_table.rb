class DropCategoriesCategoriesCorrectCountersTable < ActiveRecord::Migration
  def change
    drop_table :categories_category_correct_counters
  end
end
