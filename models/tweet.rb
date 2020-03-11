require 'sinatra/activerecord'

class Tweet < ActiveRecord::Base
  has_many :tweettags
  has_many :tags, through: :tweettags
end