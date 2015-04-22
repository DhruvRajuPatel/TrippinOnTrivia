class AddTotalDifficultyRatingToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :total_difficulty_rating, :integer, null: false, default: 0
  end
end
