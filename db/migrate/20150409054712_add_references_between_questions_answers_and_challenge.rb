class AddReferencesBetweenQuestionsAnswersAndChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :question_id, :integer
    add_column :challenges, :answer_id, :integer
    add_column :questions, :challenge_id, :integer
    add_column :answers, :challenge_id, :integer
  end
end
