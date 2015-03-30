class AddGoingForTrophyToPlayer < ActiveRecord::Migration
  def change
      add_column :players, :going_for_trophy, :boolean
      add_column :players, :category_id, :integer
      add_column :players, :question_id, :integer
  end
end
