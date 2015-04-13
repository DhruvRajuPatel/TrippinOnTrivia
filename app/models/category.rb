class Category < ActiveRecord::Base
  has_many :questions
  has_one :trophy
  has_one :achievement
  def to_s
    "#{title}"
  end
end