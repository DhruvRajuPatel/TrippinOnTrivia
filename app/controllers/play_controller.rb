class PlayController < ApplicationController
  def index
  end

  def display_spinner
    @rotations = rand(80000...100000)
    @category_number = @rotations%360
    case @category_number
      when 0..53
        $random_category = Category.all[1]
      when 54..104
        $random_category = Category.all[2]
      when 105..155
        $random_category = Category.all[3]
      when 156..206
        $random_category = Category.all[4]
      when 207..257
        $random_category = Category.all[5]
      when 258..308
        $random_category = Category.all[0]
      when 309..359
        $random_category = Category.all.shuffle[0]
    end

    respond_to do |format|
      format.html
      format.js
    end

  end

end
