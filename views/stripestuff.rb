require "stripe"
Stripe.api_key = "sk_test_ECAvVBtdKXp9xUaX8V7XjOmf"

Stripe::Charge.create(
  :amount => 2000,
  :currency => "usd",
  :customer => "cus_BuwFujRqlViinj", # obtained with Stripe.js
  :description => "Charge for noah.williams@example.com"
)

puts Stripe::Charge.list(limit: 3)
