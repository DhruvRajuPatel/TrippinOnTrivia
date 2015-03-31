class Challenge < ActiveRecord::Base
  has_one :challenger_player, class_name: "Player", foreign_key: "challenger_player_id"
  has_one :challenged_player, class_name: "Player", foreign_key: "challenged_player_id"
  has_one :bid_trophy, class_name: "Trophy", foreign_key: "bid_trophy_id"
  has_one :challenged_trophy, class_name: "Trophy", foreign_key: "challenged_trophy_id"
  has_one :winner_player, class_name: "Player", foreign_key: "winner_player_id"
  has_many :questions
  has_many :answers
end
