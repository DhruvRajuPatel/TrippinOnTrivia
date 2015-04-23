class FixPlayerRelationships < ActiveRecord::Migration
  def change
    add_column :players, :current_category_id, :integer
    add_column :players, :current_question_id, :integer
    add_column :players, :current_answer_id, :integer
  end
end
