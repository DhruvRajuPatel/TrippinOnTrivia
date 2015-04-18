class Player < ActiveRecord::Base
  belongs_to :user, foreign_key: "uid"
  has_and_belongs_to_many :trophies
  has_and_belongs_to_many :challenges
  has_one :opponent, class_name: "Player"
  has_one :current_category, class_name: "Category"
  has_one :current_question, class_name: "Question"
  has_one :current_answer, class_name: "Answer"

  def save_current_players
    self.save
    if !self.opponent.nil?
      self.opponent.save
    end
  end
end