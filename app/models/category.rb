class Category < ActiveRecord::Base
  has_many :questions
  def to_s
    "#{title}"
  end
end
