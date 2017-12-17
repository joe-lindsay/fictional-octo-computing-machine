require "rubygems"
# require "sinatra"
# require "stripe"

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

set :publishable_key, 'pk_test_tIN888KxbhuQn3Yq9Ehsy9uu'
set :secret_key, 'sk_test_ECAvVBtdKXp9xUaX8V7XjOmf'

Stripe.api_key = settings.secret_key

get '/' do
  erb :index
end

get '/stripe' do
  # "Show me what you had today!"
   erb :checkout
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

get '/hello' do
    erb :hello_form
end

post '/hello' do
    greeting = params[:greeting] || "Hi There"
    name = params[:name] || "Nobody"

    erb :greet, :locals => {'greeting' => greeting, 'name' => name}
end

get '/number' do
  "Hello world! Give me a number."

num = gets.to_i

  "Your number times 2 is " + (num * 2).to_s
end

__END__

@@ layout
  <!DOCTYPE html>
  <html>
  <head></head>
  <body>
    <%= yield %>
  </body>
  </html>

# puts "Enter the pennies you want to pay."
#
# Stripe::Charge.create(
#   :amount => gets.chomp.to_i,
#   :currency => "usd",
#   :customer => "cus_BuwFujRqlViinj", # obtained with Stripe.js
#   :description => "Charge for noah.williams@example.com"
# )
