class GameController < ApplicationController
  def start
    @random_category = Category.all.shuffle[0]
  end
end
