class AddQuestionCorrectCounterToCategoryCorrectCounter < ActiveRecord::Migration
  def change
    add_column :category_correct_counters, :questions_correct, :integer, :null => false, :default => 0
  end
end
