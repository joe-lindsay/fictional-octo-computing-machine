require "rubygems"
require "sinatra"
require "stripe"
require 'twilio-ruby'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

set :publishable_key, 'pk_test_tIN888KxbhuQn3Yq9Ehsy9uu'
set :secret_key, 'sk_test_ECAvVBtdKXp9xUaX8V7XjOmf'

Stripe.api_key = settings.secret_key


account_sid = "AC5d6208d8fbd6d44158c055fd47049e45" # Your Account SID from www.twilio.com/console
auth_token = "3aea70c85a88c56383d6f7828a28a0b4"   # Your Auth Token from www.twilio.com/console


#0/n
get '/' do
  erb :index
end

#1/n
get '/charge' do
  # "Show me what you had today!"
   erb :charge_form
end

post '/charge' do
  # Amount in cents
  @amount = 500

  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Sinatra Charge',
    :currency    => 'usd',
    :customer    => customer.id
  )

  erb :charge
end

#2/n
get '/hello' do
    erb :hello_form
end

post '/hello' do
    greeting = params[:greeting] || "Hi There"
    name = params[:name] || "Nobody"

    erb :greet, :locals => {'greeting' => greeting, 'name' => name}
end

#3/n
get '/number' do
    erb :number_form
end

post '/number' do
number = params[:small_num] * 2

  erb :number, :locals => {'number' => number}
end

#4/n
get '/phone' do
    erb :phone_form
end

post '/phone' do
  phone_number = params[:pjone]

  client = Twilio::REST::Client.new account_sid, auth_token
  message = client.messages.create(
      body: "Joe says hello",
      to: phone_number,    # Replace with your phone number
      from: +14159171657)  # Replace with your Twilio number

  puts message.sid
end

#end
