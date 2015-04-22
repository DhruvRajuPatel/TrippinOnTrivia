class ChangeAverageDifficultyToFloatInQuestions < ActiveRecord::Migration
  def up
    change_column :questions, :average_difficulty_rating, :float
  end

  def down
    change_column :questions, :average_difficulty_rating, :integer
  end
end
