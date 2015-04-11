class Trophy < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
  has_and_belongs_to_many :players
end
