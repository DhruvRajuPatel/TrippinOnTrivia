class Player < ActiveRecord::Base
  has_many :trophies
  has_one :player
end