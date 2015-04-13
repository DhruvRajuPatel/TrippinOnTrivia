class AddCategoriesCategoryCorrectCounters < ActiveRecord::Migration
  def self.up
    create_table :categories_category_correct_counters, :id => false do |t|
      t.integer :category_id
      t.integer :category_correct_counter_id
    end
  end

  def self.down
    drop_table :categories_category_correct_counters
  end
end