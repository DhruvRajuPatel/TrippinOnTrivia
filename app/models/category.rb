class Category < ActiveRecord::Base
  has_many :questions
  has_many :trophies
  def to_s
    "#{title}"
  end
end