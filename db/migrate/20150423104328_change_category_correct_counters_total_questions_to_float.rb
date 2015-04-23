class ChangeCategoryCorrectCountersTotalQuestionsToFloat < ActiveRecord::Migration
  def change
    change_column :category_correct_counters, :questions_answered, :float, :default => 0.0
  end
end
