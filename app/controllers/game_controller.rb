class GameController < ApplicationController
  def start
    @random_category = Category.all.shuffle[0]
    @random_question = @random_category.questions.all.shuffle[0]
  end
 end
