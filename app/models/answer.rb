class Answer < ActiveRecord::Base
  belongs_to :question, dependent: :destroy
  has_many :players

  def to_s
    "#{title}"
  end
end
