class WinKeeper < ActiveRecord::Base
  has_and_belongs_to_many :players
  belongs_to :user, foreign_key: "uid"

  def get_wins_against_opponent(opponent)
    i = 0
    players.each do |player|

      if player.user == opponent
        i+=1
      end
    end
    i
  end
end
