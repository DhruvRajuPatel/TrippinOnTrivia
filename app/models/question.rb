class Question < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
  has_many :answers
end
