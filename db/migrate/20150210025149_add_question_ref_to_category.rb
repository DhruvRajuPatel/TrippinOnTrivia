class AddQuestionRefToCategory < ActiveRecord::Migration
  def change
    add_reference :categories, :question, index: true
    add_foreign_key :categories, :questions
  end
end
