require "rubygems"
require "sinatra"
#require "stripe"


#Stripe.api_key = "sk_test_ECAvVBtdKXp9xUaX8V7XjOmf"

get '/' do
  "Hello world!"
end

get '/fun' do
  "Show me what you got."
end

# puts "Enter the pennies you want to pay."
#
# Stripe::Charge.create(
#   :amount => gets.chomp.to_i,
#   :currency => "usd",
#   :customer => "cus_BuwFujRqlViinj", # obtained with Stripe.js
#   :description => "Charge for noah.williams@example.com"
# )
