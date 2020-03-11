require 'sinatra/activerecord'

class Tag < ActiveRecord::Base
  has_many :tweettags
  has_many :tweets, through: :tweettags

  validate :hashtag, uniqueness: true
end