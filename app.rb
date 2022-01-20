require 'stripe'

Stripe.api_key = 'sk_test_51KK4aTBvZuyI97JjB1fydjTab0yI05xlsLb4zq6nfYn0sczQfvQehq31HURkd8uznGzbAubx0QHGJB6UeWGYpyWu00mAG9EX3T'

require 'json'
require 'sinatra'

get '/' do
  erb :index
end

post '/create-checkout-session' do
  session = Stripe::Checkout::Session.create({
    line_items: [{
      price_data: {
        currency: 'usd',
        product_data: {
          name: 'the book club subcription',
        },
        unit_amount: 2000,
      },
      quantity: 1,
    }],
    mode: 'payment',
    # Page gone to when payment succeeds
    success_url: 'http://localhost.com:4567/success',
    # Page gone to if user clicks on logo during checkout
    cancel_url: 'http://localhost.com:4567/cancel',
  })

  redirect session.url, 303
end
