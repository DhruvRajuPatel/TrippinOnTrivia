module PlayHelper

  def assign_button_labels(player)

    @has_opponent = 'Unmatched'
    @opponent_trophies = 0

    if (!player.opponent.nil?)

      @has_opponent = player.opponent.user.email
      @opponent_trophies = player.opponent.trophies.count
    end
  end
end