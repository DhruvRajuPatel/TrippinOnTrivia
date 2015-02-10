class AddAnswerRefToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :answer, index: true
    add_foreign_key :questions, :answers
  end
end
