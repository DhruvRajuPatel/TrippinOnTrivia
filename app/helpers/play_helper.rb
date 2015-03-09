module PlayHelper
  def true_answer
    if @going_for_trophy == true
      Player.first.trophies << @random_question.category.trophy
      @going_for_trophy = false
      Player.first.update_attribute(:meter, @meter + 1)
    else
      Player.first.update_attribute(:meter, @meter + 1)
      if @meter > 2
        @going_for_trophy = true
        Player.first.update_attribute(:meter, 0)
      end
    end
  end
  def false_answer
    @going_for_trophy = false
  end
end