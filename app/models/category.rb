class Category < ActiveRecord::Base
  has_many :questions
  has_one :trophy
  def to_s
    "#{title}"
  end
end