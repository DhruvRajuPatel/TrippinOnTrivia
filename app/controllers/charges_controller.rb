class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = params[:amount]
    puts 'Printing amount: '
    puts @amount
    puts 'before switch'
    case @amount
      when '99'
        points = current_user.points + 10
        current_user.update_attribute(:points, points)
      when '299'
        points = current_user.points + 50
        current_user.update_attribute(:points, points)
      when '499'
        points = current_user.points + 100
        current_user.update_attribute(:points, points)
      else
        puts 'Error on switch amount'
    end

    puts '================'
    puts @amount
    puts current_user.points
    puts '================'
    customer = Stripe::Customer.create(
        :email => current_user.email,
        :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Trippin On Triva customer',
        :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
