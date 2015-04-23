class CreateChallengesQuestions < ActiveRecord::Migration
  def self.up
    create_table :challenges_questions, :id => false do |t|
      t.integer :challenge_id
      t.integer :question_id
    end
  end

  def self.down
    drop_table :challenges_questions
  end
end
