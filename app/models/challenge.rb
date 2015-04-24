require 'shared_methods'

class Challenge < ActiveRecord::Base

  include SharedMethods

  has_and_belongs_to_many :players
  has_and_belongs_to_many :questions
  has_one :challenger_player, class_name: 'Player', foreign_key: 'challenger_player_id'
  has_one :challenged_player, class_name: 'Player', foreign_key: 'challenged_player_id'
  has_one :bid_trophy, class_name: 'Trophy', foreign_key: 'bid_trophy_id'
  has_one :challenged_trophy, class_name: 'Trophy', foreign_key: 'challenged_trophy_id'

  def self.make_new_challenge(player)
    challenge = Challenge.create(question_counter: 1, is_first_round: true, challenger_score: 0, challenged_score: 0)

    Category.all.each do |category|
      challenge.add_question_by_category_name(category.title)
      challenge.save
    end

    player.challenges << challenge
    player.opponent.challenges << challenge

    player.current_question = player.challenges.first.questions[0]

    player.current_category = player.current_question.category
    player.save_current_players
  end

  def get_next_challenge_question(player)

    player.current_question = self.questions[self.question_counter]
    player.current_category = player.current_question.category
    player.save
    self.update_attribute(:question_counter, self.question_counter + 1)
  end

  def end_challenge_round(player)

    player.update_attribute(:is_current_turn, false)
    self.update_attribute(:question_counter, 0)

    if self.is_first_round
      proceed_to_next_round(player)

    else
      decide_winner(player)
      end_current_challenge(player)
    end
  end

  def handle_correct_answer

    if self.is_first_round

      self.update_attribute(:challenger_score, self.challenger_score + 1)

    else

      self.update_attribute(:challenged_score, self.challenged_score + 1)
    end
  end

  def set_challenge_trophies(trophy)

    if self.bid_trophy.nil?

      self.bid_trophy = trophy

    else

      self.challenged_trophy = trophy
    end
  end

  def end_current_challenge(player)

    if player.has_opponent

      player.opponent.challenges.delete(self)
    end

    if player.challenges.first.nil?

      player.current_question = nil
      player.current_category = nil
    end

    player.opponent.current_question = nil
    player.opponent.current_category = nil
    player.save_current_players
    player.challenges.delete(self)
  end

  def add_question_by_category_name(category_name)

    self.questions << Category.find_by_title(category_name).questions.all_non_user_submitted.shuffle[0]
  end

  private

  def challenger_player_wins(challenger_player)

    challenger_player.opponent.trophies.delete(self.challenged_trophy)
    challenger_player.trophies << self.challenged_trophy
    challenger_player.update_attribute(:is_current_turn, true)
    challenger_player.save_current_players
  end

  def challenged_player_wins(challenged_player)

    challenged_player.opponent.trophies.delete(self.bid_trophy)
    challenged_player.update_attribute(:is_current_turn, true)
    challenged_player.save_current_players
  end

  def decide_winner(player)

    if self.challenged_score > self.challenger_score

      challenged_player_wins(player)
    else

      challenger_player_wins(player.opponent)
    end
  end

  def proceed_to_next_round(player)

    player.opponent.update_attribute(:is_current_turn, true)
    self.update_attribute(:is_first_round, false)
  end
end