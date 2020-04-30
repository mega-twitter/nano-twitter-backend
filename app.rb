#nano twitter
require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require_relative './models/tweet'
require_relative './models/user'

get '/search' do 
  @key_word = params[:search].downcase
  sql = "SELECT tweets.* FROM tweets, plainto_tsquery('#{@key_word}') AS q WHERE (tsv_tweet @@ q) 
  ORDER BY tweets.created_at DESC"
  @result_tweet = ActiveRecord::Base.connection.execute(sql)
  # @result_user = User.all.where("lower(name) LIKE ?", "%#{@key_word}%")
  status 200
  @result_tweet.to_json
end

