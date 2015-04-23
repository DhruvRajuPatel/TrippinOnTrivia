module PlayHelper

  def assign_button_labels(player)

    @has_opponent = 'Unmatched'
    @opponent_trophies = 0

    if (!player.opponent.nil?)

      @opponent = player.opponent
      @has_opponent = player.opponent.user.email
      @opponent_trophies = player.opponent.trophies.count
    end
  end

  def show_user_options(user)
     if @friends.include? user

              link_to "Delete Friend", Friendship.find_by_friend_id(user), :method => :delete

          else

    link_to "Add Friend", friendships_path(:friend_id => user), :method => :post
        end
  end
end