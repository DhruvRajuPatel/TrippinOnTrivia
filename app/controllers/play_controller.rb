class PlayController < ApplicationController

  LEVEL_UP_STATIC_THRESHOLD = 3
  LEVEL_UP_DYNAMIC_THRESHOLD = 2

  def index

  end

  def display_spinner
    @until_level_up = get_current_player_level_up_threshold

    current_user.active_player.update_attribute(:going_for_trophy, false)
    if current_user.active_player.isActivePlayer && current_user.active_player.challenge.nil?
      @rotations = rand(80000...100000)
      @category_number = @rotations%360
      case @category_number
        when 0..53
          @random_category = Category.find_by_title('Aquatic Animals')
        when 54..104
          @random_category = Category.find_by_title('Memes')
        when 105..155
          @random_category = Category.find_by_title('Basketball')
        when 156..206
          @random_category = Category.find_by_title('Contemporary Literature')
        when 207..257
          @random_category = Category.find_by_title('Music')
        when 258..308
          @random_category = Category.find_by_title('Computer Science')
        when 309..359
          current_user.active_player.update_attribute(:meter, 3)
      end
      current_user.active_player.current_category = @random_category
    end

    respond_to do |format|
      format.html
      format.js
    end

  end

  def display_new_game_page
    current_user.active_player = current_user.players.create(meter: 0, isActivePlayer: true)

    Player.all.each do |player|
      if player.user != current_user && player.opponent.nil? && !player.isActivePlayer
        current_user.active_player.opponent = player
        player.opponent = current_user.active_player
        break
      end
    end
  end

  def display_questions
    current_user.active_player.current_question = current_user.active_player.current_category.questions.all.shuffle[0]

    def true_answer
      current_user.update_attribute(:total_correct, current_user.total_correct + 1)

      if current_user.total_correct == get_current_player_level_up_threshold
        current_user.update_attribute(:level, current_user.level + 1)
      end

      if current_user.active_player.going_for_trophy
        current_user.active_player.trophies << current_user.active_player.current_question.category.trophy
        current_user.active_player.update_attribute(:going_for_trophy, false)
      elsif current_user.active_player.challenge.nil?
        current_user.active_player.update_attribute(:meter, current_user.active_player.meter + 1)
      elsif current_user.active_player.challenge.challenger_player == current_user.active_player
        current_user.active_player.challenge.update_attribute(:challenger_player_score, current_user.active_player.challenge.challenger_player_score + 1)
      else
        current_user.active_player.challenge.update_attribute(:challenged_player_score, current_user.active_player.challenge.challenged_player_score + 1)
      end
    end

    def false_answer
      current_user.active_player.update_attribute(:going_for_trophy, false)
      if current_user.active_player.challenge.nil?
      current_user.active_player.update_attribute(:isActivePlayer, false)
      current_user.active_player.opponent.update_attribute(:isActivePlayer, true)
        end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end


  def display_trophy_select
    @categories = Category.all
    current_user.active_player.update_attribute(:going_for_trophy, true)
    current_user.active_player.update_attribute(:meter, 0)
  end

  def display_full_meter_choice
    current_user.active_player.update_attribute(:meter, 0)
  end

  def get_trophy_category
    if current_user.active_player.challenge.nil?
    current_user.active_player.current_category = Category.find(params[:category_id])
    elsif current_user.active_player.challenge.bid_trophy.nil?
      current_user.active_player.challenge.bid_trophy = Trophy.find(params[:trophy_id])
    else
      current_user.active_player.challenge.challenged_trophy = Trophy.find(params[:trophy_id])
      end
  end

  def get_selected_player
    current_user.active_player = current_user.players.find(params[:player_id])
  end

  def make_new_challenge
    challenge = Challenge.create(question_counter: 1)
    challenge.challenger_player = current_user.active_player
    challenge.challenged_player = current_user.active_player.opponent
    current_user.active_player.opponent.challenge = challenge
    current_user.active_player.challenge = challenge

    current_user.active_player.challenge.questions << Category.find_by_title('Aquatic Animals').questions.all.shuffle[0]
    current_user.active_player.challenge.questions << Category.find_by_title('Computer Science').questions.all.shuffle[0]
    current_user.active_player.challenge.questions << Category.find_by_title('Music').questions.all.shuffle[0]
    current_user.active_player.challenge.questions << Category.find_by_title('Contemporary Literature').questions.all.shuffle[0]
    current_user.active_player.challenge.questions << Category.find_by_title('Basketball').questions.all.shuffle[0]
    current_user.active_player.challenge.questions << Category.find_by_title('Memes').questions.all.shuffle[0]

    current_user.active_player.current_question = current_user.active_player.challenge.questions[0]

    current_user.active_player.current_category = current_user.active_player.current_question.category
  end

  def get_next_challenge_question
    if current_user.active_player.challenge.question_counter < 6
      current_user.active_player.current_question = current_user.active_player.challenge.questions[current_user.active_player.challenge.question_counter]
      current_user.active_player.challenge.update_attribute(:question_counter, current_user.active_player.challenge.question_counter + 1)
      current_user.active_player.current_category = current_user.active_player.current_question.category
    else
      current_user.active_player.update_attribute(:isActivePlayer, false)
      current_user.active_player.challenge.update_attribute(:question_counter, 0)
      if current_user.active_player.challenge.challenger_player == current_user.active_player
        current_user.active_player.opponent.update_attribute(:isActivePlayer, true)
      else
        if current_user.active_player.challenge.challenged_player_score > current_user.active_player.challenge.challenger_player_score
          current_user.active_player.opponent.trophies.delete(current_user.active_player.challenge.bid_trophy)
        else
          current_user.active_player.trophies.delete(current_user.active_player.challenge.challenged_trophy)
          current_user.active_player.opponent.trophies << current_user.active_player.challenge.challenged_trophy
        end
        current_user.active_player.challenge = nil
        current_user.active_player.opponent.challenge = nil
      end
    end
  end

  private

  def get_current_player_level_up_threshold

    current_dynamic_threshold = get_recursive_definition(current_user.level, LEVEL_UP_DYNAMIC_THRESHOLD)
    current_static_threshold = LEVEL_UP_STATIC_THRESHOLD * current_user.level

    return current_dynamic_threshold + current_static_threshold

  end

  def get_recursive_definition(times_to_iterate, numeric_definition)
    current_sum = 0

    if times_to_iterate - 1 > 0

      current_sum = get_recursive_definition(times_to_iterate - 1, numeric_definition)
    end

    return numeric_definition * times_to_iterate + current_sum

  end

end
