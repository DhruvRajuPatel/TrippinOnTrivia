class CategoryCorrectCounter < ActiveRecord::Base
  belongs_to :user, foreign_key: "uid"
  belongs_to :scoreboard
  has_and_belongs_to_many :categories

  def get_percent_correct

    percent_correct = 0.0

    if questions_answered > 0

      percent_correct = questions_correct / questions_answered
    end

    percent_correct * 100

  end
end
