class GameController < ApplicationController
  def start
    @random_category = Category.all.shuffle[0]
    @random_question = @random_category.questions.all.shuffle[0]

    # This is just to demo we can query our database both ways... Implementation is in the game view/start.
    @answers = @random_question.answers
    @random_answer = Answer.all.shuffle[0]
  end
  end
