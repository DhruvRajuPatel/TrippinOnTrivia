class RenameTotalDifficultyQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :total_difficulty_rating, :average_difficulty_rating
  end
end
