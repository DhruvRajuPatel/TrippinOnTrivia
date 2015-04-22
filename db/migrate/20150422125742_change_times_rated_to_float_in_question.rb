class ChangeTimesRatedToFloatInQuestion < ActiveRecord::Migration
  def up
    change_column :questions, :times_rated, :float
  end

  def down
    change_column :questions, :times_rated, :integer
  end
end
