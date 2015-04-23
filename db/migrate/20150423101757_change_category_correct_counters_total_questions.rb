class ChangeCategoryCorrectCountersTotalQuestions < ActiveRecord::Migration
  def change
    change_column :category_correct_counters, :questions_answered, :integer, :default => 0
  end
end