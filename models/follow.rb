require 'sinatra/activerecord'

class Follow < ActiveRecord::Base
  belongs_to :user
end