class Category < ActiveRecord::Base
  has_many :questions
  has_many :players
  has_and_belongs_to_many :category_correct_counters
  has_one :trophy
  has_one :achievement

  def to_s
    "#{title}"
  end
end