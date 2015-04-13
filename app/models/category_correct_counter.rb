class CategoryCorrectCounter < ActiveRecord::Base
  belongs_to :user, foreign_key: "uid"
  has_and_belongs_to_many :categories
end
