require 'faker'
require 'random/password'
require 'random/password'
include RandomPassword

User.delete_all
Comment.delete_all
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

# create tweet for each user
User.all.each do |user|
  rand(tweet_max).times do
    tag = ["", "#"+Faker::Lorem.word].sample
    tweet = Tweet.create!(content: Faker::Lorem.paragraph + tag,
                          user_id: user.id)
    # if tweet has a tag, create corresponding tag and tweettag object
    if !tag.empty?
      begin
        hashtag = Tag.create!(hashtag: tag)
        Tweettag.create!(tag_id: hashtag.id,
                         tweet_id: tweet.id)
      rescue
        # do nothing
      end
    end
  end
end

# create follower followee relationship
User.all.each do |user|
  rand(follower_max).times do
    follower = User.all.sample
    if user == follower
      next
    else
      Follow.create!(follower_user_id: follower.id,
                     followee_user_id: user.id
      )
    end
  end
end


