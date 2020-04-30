require './models/follow.rb'
require './models/tag.rb'
require './models/tweet.rb'
require './models/tweettag.rb'

require 'faker'
require 'random/password'
require 'csv'
include RandomPassword

User.delete_all
# Comment.delete_all
Follow.delete_all
Tag.delete_all
Tweet.delete_all
Tweettag.delete_all

# define parameters
user_num = 50 # number of users in the database
tweet_max = 10 # maximum number of tweeter per user
follower_max = 10 # maxinum number follower for each user

# create users
user_num.times do
  password = generate(16)
  User.create!(name: Faker::Name.name, 
               email: Faker::Internet.email,
               self_intro: Faker::Quote.yoda, 
               password: password, 
               password_confirmation: password)
end


users = User.order(:created_at).take(6)
5.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.tweets.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
