class Question < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
  has_many :answers

  def to_s
    "#{title}"
  end

  def calculate_difficulty_rating

    difficulty = 0

    if self.times_rated != 0

      difficulty = self.rating / self.times_rated
    end

    difficulty
  end
end
