class PlayController < ApplicationController
  before_action :authenticate_user!


  LEVEL_UP_STATIC_THRESHOLD = 3
  LEVEL_UP_DYNAMIC_THRESHOLD = 2
  CATEGORY_ACHIEVEMENT_THRESHOLD = 20
  SPINNER_DEGREES = 360
  FULL_METER_AMOUNT = 3

  def index

  end

  def display_spinner

    current_user.active_player.update_attribute(:going_for_trophy, false)
    detect_cheating
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
    end
    current_user.active_player.current_category = random_category
  end

  def detect_cheating
    if !current_user.active_player.current_question.nil?
      punish_cheater
    else
      detect_if_bailed_on_unused_challenge
    end
  end

  def punish_cheater
    if !current_user.active_player.challenges.first.nil?
      end_challenge_round
    else
      change_active_player
    end
    finish_question
  end

  def detect_if_bailed_on_unused_challenge
    if !current_user.active_player.challenges.first.nil? && current_user.active_player.challenges.first.is_first_round
      end_current_challenge
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

    if current_user.active_player.challenges.first.nil?
      current_user.active_player.current_question = current_user.active_player.current_category.questions.all.shuffle[0]
    end

    def true_answer
      update_question_statistics

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

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update_question_statistics
    current_user.update_attribute(:total_correct, current_user.total_correct + 1)

    update_category_question_statistics()

    if current_user.total_correct == get_current_player_level_up_threshold
      current_user.update_attribute(:level, current_user.level + 1)
    end
  end

  def update_category_question_statistics()

    category = current_user.active_player.current_category

    if category == current_user.aquatic_counter.categories.first
      increment_counter(current_user.aquatic_counter, category)

    elsif category == current_user.memes_counter.categories.first
      increment_counter(current_user.memes_counter, category)

    elsif category == current_user.basketball_counter.categories.first
      increment_counter(current_user.basketball_counter, category)

    elsif category == current_user.literature_counter.categories.first
      increment_counter(current_user.literature_counter, category)

    elsif category == current_user.music_counter.categories.first
      increment_counter(current_user.music_counter, category)

    elsif category == current_user.cs_counter.categories.first
      increment_counter(current_user.cs_counter, category)
    end
  end

  def increment_counter(counter, category)
    counter.update_attribute(:questions_correct, counter.questions_correct + 1)
    check_if_award_category_achievement(counter.questions_correct, category)
  end

  def check_if_award_category_achievement(questions_correct, category)
    if questions_correct == CATEGORY_ACHIEVEMENT_THRESHOLD
      current_user.achievements << category.achievement
      current_user.update_attribute(:has_new_achievement, true)
    end
  end

  def achievement_message_recieved
    current_user.update_attribute(:has_new_achievement, false)
    render nothing: true
  end

  def finish_question
    current_user.active_player.current_question = nil;
    current_user.active_player.current_category = nil;
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

  def make_new_challenge
    challenge = Challenge.create(question_counter: 1, is_first_round: true, challenger_score: 0, challenged_score: 0)

    current_user.active_player.challenges << challenge
    current_user.active_player.opponent.challenges << challenge

    current_user.active_player.challenges.first.questions << Category.find_by_title('Aquatic Animals').questions.shuffle[0]
    current_user.active_player.challenges.first.questions << Category.find_by_title('Computer Science').questions.shuffle[0]
    current_user.active_player.challenges.first.questions << Category.find_by_title('Music').questions.shuffle[0]
    current_user.active_player.challenges.first.questions << Category.find_by_title('Contemporary Literature').questions.shuffle[0]
    current_user.active_player.challenges.first.questions << Category.find_by_title('Basketball').questions.shuffle[0]
    current_user.active_player.challenges.first.questions << Category.find_by_title('Memes').questions.shuffle[0]

    current_user.active_player.current_question = current_user.active_player.challenges.first.questions[0]

    current_user.active_player.current_category = current_user.active_player.current_question.category
  end

  def continue_challenge

    if current_user.active_player.challenges.first.question_counter < Category.all.length
      get_next_challenge_question
    else
      end_challenge_round
    end
  end

  def get_next_challenge_question
    current_user.active_player.current_question = current_user.active_player.challenges.first.questions[current_user.active_player.challenges.first.question_counter]
    current_user.active_player.challenges.first.update_attribute(:question_counter, current_user.active_player.challenges.first.question_counter + 1)
    current_user.active_player.current_category = current_user.active_player.current_question.category
  end

  def end_challenge_round
    current_user.active_player.update_attribute(:isActivePlayer, false)
    current_user.active_player.challenges.first.update_attribute(:question_counter, 0)

    if current_user.active_player.challenges.first.is_first_round
      current_user.active_player.opponent.update_attribute(:isActivePlayer, true)
      current_user.active_player.challenges.first.update_attribute(:is_first_round, false)
    else
      if current_user.active_player.challenges.first.challenged_score > current_user.active_player.challenges.first.challenger_score
        challenged_player_wins(current_user.active_player)
      else
        challenger_player_wins(current_user.active_player.opponent)
      end
      end_current_challenge
    end
  end

  def challenger_player_wins(challenger_player)
    challenger_player.opponent.trophies.delete(current_user.active_player.challenges.first.challenged_trophy)
    challenger_player.trophies << current_user.active_player.challenges.first.challenged_trophy
    challenger_player.update_attribute(:isActivePlayer, true)
  end

  def challenged_player_wins(challenged_player)
    challenged_player.opponent.trophies.delete(current_user.active_player.challenges.first.bid_trophy)
    challenged_player.update_attribute(:isActivePlayer, true)
  end

  def end_current_challenge
    current_user.active_player.challenges.delete(current_user.active_player.challenges.first)

    if !current_user.active_player.opponent.nil?
      current_user.active_player.opponent.challenges.delete(current_user.active_player.opponent.challenges.first)
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
