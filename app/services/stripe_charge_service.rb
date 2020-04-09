require 'stripe'

class StripeChargeService
    DEFAULT_CURRENCY = 'usd'.freeze

    def initialize(params, user)
        @stripe_email = params[:stripeEmail]
        @stripe_token = params[:stripeToken]
        @order_id = params[:order_id]
        @user = user
    end

    def call
        create_charge(find_customer)
    end

    private

   # attr_acccessor :user, :stripe_email, :stripe_token, :order_id

    def find_customer
        #TODO:how does stripe_token get assigned to user?
        if @user.stripe_token
            retrieve_customer         
        else
            create_customer
        end
    end

    def retrieve_customer()
        Stripe::Customer.retrieve(@stripe_token)
    end

    def create_customer()
        customer = Stripe::Customer.create(email: @stripe_email, 
                                            source: @stripe_token)
        #TODO: persist user
        #@user.update(stripe_token: customer.id)
        customer
    end

    def create_charge(customer)
        charge = Stripe::Charge.create( customer: customer.id, 
                                amount: order_amount,
                                description: customer.email,
                                currency: DEFAULT_CURRENCY)
            charge
    end

    def order_amount
        #Order.find_by(id: order_id).amount
        amount = 123
    end

end
