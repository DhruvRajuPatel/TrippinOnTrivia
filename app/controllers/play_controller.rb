class PlayController < ApplicationController
  def index

  end

  def display_spinner
    current_user.active_player.update_attribute(:going_for_trophy, false)
    if current_user.active_player.isActivePlayer
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
    @question = current_user.active_player.current_category.questions.all.shuffle[0]
    current_user.active_player.current_question = @question

    def true_answer

      if current_user.active_player.going_for_trophy
        current_user.active_player.trophies << current_user.active_player.current_question.category.trophy
        current_user.active_player.update_attribute(:going_for_trophy, false)
      else
        current_user.active_player.update_attribute(:meter, current_user.active_player.meter + 1)
      end
    end

    def false_answer
      current_user.active_player.update_attribute(:going_for_trophy, false)
      current_user.active_player.update_attribute(:isActivePlayer, false)
      current_user.active_player.opponent.update_attribute(:isActivePlayer, true)
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

  def get_trophy_category
    current_user.active_player.current_category = Category.find(params[:category_id])
  end

  def get_selected_player
    current_user.active_player = current_user.players.find(params[:player_id])
  end

end
