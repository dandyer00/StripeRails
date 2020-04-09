require_relative '../services/stripe_charge_service'

class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception

  def new
    @order_price = 1.23
    @email = "ddyer@cableone.net"
    @user_name = 'dandyer00'
  end

  def create
    @user = User.where(email: @email, user_name: @user_name).first_or_create()
    'dandyer00' #current_user
    StripeChargeService.new(charges_params, @user).call
    redirect_to new_charge_path
  end

  private

  def charges_params
    params.permit(:stripeEmail, :stripeToken, :order_id)
  end

  def catch_exception(exception)
    flash[:error] = exception.message

  end
  
end

