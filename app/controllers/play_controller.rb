class PlayController < ApplicationController
  before_action :authenticate_user!

  SPINNER_DEGREES = 360
  FULL_METER_AMOUNT = 3

  $category_amount = Category.all.count

  def index

  end

  def display_friends
    @users = User.all
    render :layout => false
  end

  def display_spinner

    current_user.active_player.update_attribute(:going_for_trophy, false)
    if !current_user.active_player.current_question.nil?
      detect_cheating
    end
    check_win
  end

  def get_random_category
    rotations = params[:rotations].to_i
    category_number = rotations % SPINNER_DEGREES

    case category_number
      when 0..53
        random_category = Category.find_by_title('Aquatic Animals')
      when 54..104
        random_category = Category.find_by_title('Memes')
      when 105..155
        random_category = Category.find_by_title('Basketball')
      when 156..206
        random_category = Category.find_by_title('Contemporary Literature')
      when 207..257
        random_category = Category.find_by_title('Music')
      when 258..308
        random_category = Category.find_by_title('Computer Science')
      when 309..359
        current_user.active_player.update_attribute(:meter, FULL_METER_AMOUNT)
      else
        random_category = Category.all.shuffle.first
    end
    current_user.active_player.current_category = random_category
  end

  def check_win
    if current_user.active_player.trophies.count >= $category_amount
      set_victory(current_user.active_player)
    end
  end

  def resign
    if current_user.active_player.opponent.nil?
      end_game
    else
      set_victory(current_user.active_player.opponent)
    end
  end

  def set_victory(player)
    player.update_attribute(:has_won, true)
    player.user.update_attribute(:win_count, player.user.win_count + 1)
    end_game
  end

  def end_game
    current_user.active_player.update_attribute(:is_inactive, true)
    current_user.active_player.update_attribute(:isActivePlayer, false)
    if !current_user.active_player.opponent.nil?
      current_user.active_player.opponent.update_attribute(:is_inactive, true)
      current_user.active_player.opponent.update_attribute(:isActivePlayer, false)
    end
  end

  def detect_cheating
    if current_user.active_player.isActivePlayer
      punish_cheater
    end
    finish_question
  end

  def punish_cheater
    if current_user.active_player.challenges.first.nil?
      change_active_player
    elsif current_user.active_player.challenges.first.question_counter > 1 || !current_user.active_player.challenges.first.is_first_round
      current_user.active_player.challenges.first.end_challenge_round(current_user.active_player)
    else
      current_user.active_player.challenges.first.end_current_challenge(current_user.active_player)
    end
  end

  def finish_question
    if current_user.active_player.challenges.first.nil?
      current_user.active_player.current_question = nil
      current_user.active_player.current_category = nil
    end
  end

  def play_friend
    user = User.find(params[:id])
    user.players.all.each do |player|
      if player.user != current_user && player.opponent.nil? && !player.isActivePlayer && !player.is_inactive
        current_user.active_player.opponent = player
        player.opponent = current_user.active_player
        break
      end
    end
    if current_user.active_player.opponent.nil?
      new_player = user.players.create(isActivePlayer: false, meter: 0)
      current_user.active_player.opponent = new_player
      new_player.opponent = current_user.active_player
    end
  end

  def display_new_game_page
    current_user.active_player = current_user.players.create(meter: 0, isActivePlayer: true)

    Player.all.each do |player|
      if player.user != current_user && player.opponent.nil? && !player.isActivePlayer && !player.is_inactive
        current_user.active_player.opponent = player
        player.opponent = current_user.active_player
        break
      end
    end
  end

  def eliminate
    current_user.update_attribute(:points, current_user.points - 1)
  end

  def toggle_mute
    muted = !current_user.muted
    current_user.update_attribute(:muted,muted)
    render :nothing => true
  end

  def phone_google
    current_user.update_attribute(:points, current_user.points - 1)
  end

  def display_questions

    if current_user.active_player.challenges.first.nil?
      current_user.active_player.current_question = current_user.active_player.current_category.questions.all.shuffle[0]
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def true_answer
    current_user.update_question_statistics

    if current_user.active_player.going_for_trophy
      current_user.active_player.trophies << current_user.active_player.current_question.category.trophy
      current_user.active_player.update_attribute(:going_for_trophy, false)
    elsif current_user.active_player.challenges.first.nil?
      current_user.active_player.update_attribute(:meter, current_user.active_player.meter + 1)
    elsif current_user.active_player.challenges.first.is_first_round
      current_user.active_player.challenges.first.update_attribute(:challenger_score, current_user.active_player.challenges.first.challenger_score + 1)
    else
      current_user.active_player.challenges.first.update_attribute(:challenged_score, current_user.active_player.challenges.first.challenged_score + 1)
    end
  end

  def false_answer
    current_user.active_player.update_attribute(:going_for_trophy, false)
    if current_user.active_player.challenges.first.nil?
      change_active_player
    end
  end

  def achievement_message_recieved
    current_user.update_attribute(:has_new_achievement, false)
    render nothing: true
  end

  def change_active_player
    current_user.active_player.update_attribute(:isActivePlayer, false)
    if !current_user.active_player.opponent.nil?
      current_user.active_player.opponent.update_attribute(:isActivePlayer, true)
    end
  end


  def display_trophy_select
    @categories = Category.all
    current_user.active_player.update_attribute(:going_for_trophy, true)
    current_user.active_player.update_attribute(:meter, 0)
  end

  def display_full_meter_choice
    current_user.active_player.update_attribute(:meter, 0)
    if !current_user.active_player.opponent.nil?
      Challenge.make_new_challenge(current_user.active_player)
    end
  end

  def get_trophy_category
    if current_user.active_player.challenges.first.nil?
      current_user.active_player.current_category = Category.find(params[:category_id])
    elsif current_user.active_player.challenges.first.bid_trophy.nil?
      current_user.active_player.challenges.first.bid_trophy = Trophy.find(params[:trophy_id])
    else
      current_user.active_player.challenges.first.challenged_trophy = Trophy.find(params[:trophy_id])
    end
  end

  def get_selected_player
    current_user.active_player = current_user.players.find(params[:player_id])
  end



  private



end
