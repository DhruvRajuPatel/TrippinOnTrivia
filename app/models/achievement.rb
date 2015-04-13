class Achievement < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :users, foreign_key: "uid"
end
