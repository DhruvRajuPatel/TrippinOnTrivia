class Player < ActiveRecord::Base
  belongs_to :user, foreign_key: "uid"
  has_many :trophies
  has_one :opponent, class_name: "Player"
  has_one :current_category, class_name: "Category"
  has_one :current_question, class_name: "Question"
end