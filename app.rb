require "rubygems"
require "sinatra"
require "stripe"
require 'twilio-ruby'
require 'sendgrid-ruby'
require 'sqlite3'
require relative '../../app-env'
include SendGrid

set :port, 8080
# set :static, true
# set :public_folder, "static"
# set :views, "views"

set :publishable_key, 'pk_test_tIN888KxbhuQn3Yq9Ehsy9uu'
#set :secret_key, 'sk_test_ECAvVBtdKXp9xUaX8V7XjOmf'

Stripe.api_key = Stripe_secret #settings.secret_key


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

  erb :charge_redir
end

#2/n
get '/hello' do
    erb :hello_form
end

post '/hello' do
    greeting = params[:greeting] || "Hi There"
    name = params[:name] || "friend"

    erb :hello_redir, :locals => {'greeting' => greeting, 'name' => name}
end

#3/n
get '/number' do
    erb :number_form
end

post '/number' do
number = params[:small_num] * 2

  erb :number_redir, :locals => {'number' => number}
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

  erb :phone_redir, :locals => {'number' => phone_number}
end

#5/n
post '/email' do
  from = Email.new(email: 'test@example.com')
  to = Email.new(email: 'joe.lindsay20@gmail.com')
  subject = 'Sending with SendGrid is Fun'
  content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: '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')
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers
end

#6/n
get '/map' do
  erb :map_static
end

#7/n
get '/data' do
  # Open a database
  db = SQLite3::Database.new "test.db"

  # Create a table
  # rows = db.execute <<-SQL
  #   create table numbers (
  #     name varchar(30),
  #     val int
  #   );
  # SQL

  # Execute a few inserts
  # {
  #   "one" => 1,
  #   "two" => 2,
  # }.each do |pair|
  #   db.execute "insert into numbers values ( ?, ? )", pair
  # end

  # Find a few rows
  db.execute( "select * from numbers" ) do |row|
    p row
  end

  # Create another table with multiple columns

  # db.execute <<-SQL
  #   create table students (
  #     name varchar(50),
  #     email varchar(50),
  #     grade varchar(5),
  #     blog varchar(50)
  #   );
  # SQL

  # Execute inserts with parameter markers
  db.execute("INSERT INTO students (name, email, grade, blog)
              VALUES (?, ?, ?, ?)", ["Jane", "me@janedoe.com", "A", "http://blog.janedoe.com"])

  db.execute( "select * from students" ) do |row|
    p row
  end
end

#8/n
get '/nextsteps' do
  erb :nextsteps_static
end

#end
