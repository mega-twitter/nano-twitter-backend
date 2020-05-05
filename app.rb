#nano twitter
require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'redis'
require_relative './models/tweet'
require_relative './models/user'

set :redis, Redis.new(host: "157.245.114.60", port: 6379)

get '/search_tweet' do 
  @key_word = params[:search].downcase
  @page = params[:page]
  @offset = (@page.to_i - 1) * 10
  
  if @offset < 0
    @offset = 0
  end

redis_key = "search_" + @key_word + "-" + @page

  if !settings.redis.exists(redis_key)
    puts redis_key
    sql = "SELECT user_id, content, created_at FROM tweets, plainto_tsquery('#{@key_word}') AS q WHERE (tsv_tweet @@ q) 
  ORDER BY tweets.created_at DESC LIMIT 10 OFFSET #{@offset}"
    @result_tweet = ActiveRecord::Base.connection.execute(sql)
    @result_tweet.each do |tweet|
      settings.redis.rpush(redis_key, tweet.to_json)
    end
    status 200
  else
    puts "in redis!"
    @tweet_items = settings.redis.lrange(redis_key, 0, -1)
    @result_tweet = @tweet_items.map{|tweet| JSON.parse(tweet)}
  end
  @result_tweet.to_json
end

get '/search_user' do 
  @key_word = params[:search].downcase
  sql = "SELECT id, name FROM users where lower(name) LIKE '%#{@key_word}%'"
  @result_user = ActiveRecord::Base.connection.execute(sql)
  status 200
  @result_user.to_json
end

get '/test/status' do
  user_count = User.count
  tweet_count = Tweet.count
  follow_count = Follow.count

  "<h3> Count users: #{user_count}</h3>
  <h3> Count tweets: #{tweet_count}</h3>
  <h3> Count follows: #{follow_count}</h3>"

end