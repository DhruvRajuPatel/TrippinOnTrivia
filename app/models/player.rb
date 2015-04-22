class Player < ActiveRecord::Base
  belongs_to :user, foreign_key: "uid"
  has_and_belongs_to_many :trophies
  has_and_belongs_to_many :challenges
  has_one :opponent, class_name: "Player"
  has_one :current_category, class_name: "Category"
  has_one :current_question, class_name: "Question"
  has_one :current_answer, class_name: "Answer"

  $category_amount = Category.all.count
  FULL_METER_AMOUNT = 3

  def get_random_opponent_from_group(group = Player.all)

    group.all_waiting_active_players.each do |opponent|

      if opponent.user != self.user && opponent.opponent.nil?

        self.opponent = opponent
        opponent.opponent = self
        break
      end
    end
  end

  def save_current_players

    self.save

    if has_opponent

      self.opponent.save
    end
  end

  def set_user_as_opponent(user)
    self.get_random_opponent_from_group(user.players.all)
    if self.opponent.nil?
      new_player = user.players.create(isActivePlayer: false, meter: 0)
      self.opponent = new_player
      new_player.opponent = self
    end
  end


  def check_win

    if self.trophies.count >= $category_amount

      set_victory
    end
  end

  def resign

    if has_opponent

      self.opponent.set_victory

    else

      end_game
    end
  end

  def set_category_by_degree(degree)

    case degree

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
        fill_meter
        random_category = Category.all.shuffle.first

      else

        random_category = Category.all.shuffle.first
    end

    self.current_category = random_category
  end

  def detect_cheating

    if self.isActivePlayer

      punish_cheating_player
    end

    finish_question
  end

  def finish_question

    if !has_active_challenge

      self.current_question = nil
      self.current_category = nil
    end
  end

  def respond_correctly

    if self.going_for_trophy

      self.trophies << self.current_question.category.trophy
      self.update_attribute(:going_for_trophy, false)

    elsif has_active_challenge

      self.challenges.first.handle_correct_answer

    else

      self.update_attribute(:meter, self.meter + 1)
    end
  end

  def respond_incorrectly

    self.update_attribute(:going_for_trophy, false)

    if !has_active_challenge

      change_active_player
    end
  end

  def has_opponent
    !self.opponent.nil?
  end

  def has_active_challenge
    !self.challenges.first.nil?
  end

  private

  def self.all_waiting_active_players

    where('isActivePlayer = ? AND is_inactive = ?', false, false)
  end

  def set_victory

    self.update_attribute(:has_won, true)
    self.user.update_attribute(:win_count, self.user.win_count + 1)
    end_game

  end

  def punish_cheating_player

    if !has_active_challenge

      change_active_player

    elsif self.challenges.first.question_counter > 1 || !self.challenges.first.is_first_round

      self.challenges.first.end_challenge_round(self)

    else

      self.challenges.first.end_current_challenge(self)
    end
  end

  def change_active_player

    self.update_attribute(:isActivePlayer, false)

    if has_opponent

      self.opponent.update_attribute(:isActivePlayer, true)
    end
  end

  def fill_meter

    self.update_attribute(:meter, FULL_METER_AMOUNT)
  end

  def end_game

    self.close_player

    if has_opponent

      self.opponent.close_player

    end

    save_current_players
  end

  def close_player

    self.update_attribute(:is_inactive, true)
    self.update_attribute(:isActivePlayer, false)

  end

end