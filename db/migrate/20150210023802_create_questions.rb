class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.integer :rating

      t.references :category, index: true

      t.timestamps null: false
    end
  end
end
