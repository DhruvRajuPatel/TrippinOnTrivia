class AddTimesRatedToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :times_rated, :integer, null: false, default: 1
  end
end
