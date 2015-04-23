class Question < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
  has_many :answers
  has_many :players
  accepts_nested_attributes_for :answers


  def self.get_questions_by_difficulty

     all_non_user_submitted.order(:average_difficulty_rating)
  end

  def self.all_non_user_submitted

    where('user_submitted = ?', false)
  end

  def self.get_question_by_user_level(user)

    questions = Question.get_questions_by_difficulty
    size = questions.count

    lower_upper_bounds = user.get_max_level_progression * size
    upper_lower_bounds = rand(0...lower_upper_bounds)
    index_lower_bounds = rand(0...lower_upper_bounds)
    index_upper_bounds = rand(upper_lower_bounds ... size)
    index = rand(index_lower_bounds .. index_upper_bounds)

    questions[index]
  end

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
