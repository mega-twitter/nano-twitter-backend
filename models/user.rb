require 'bcrypt'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  include BCrypt

  # associations
  has_many :follows
  has_many :followers, through: :follows, source: :users

  # validations
  validates_presence_of :name
  validates_presence_of :email
  validates_length_of :password, minimum: 3

  # methods
  def self.authenticate(user_email, password)
    user = find_by(email: user_email)
    if user.nil?
      return {
        :user_id => nil,
        :status => "nil user"
      }.to_json
    else
      if user.password == password
        return {
          :user_id => user,
          :status => "success"
        }.to_json
      else
        return {
          :user_id => user,
          :status => "wrong password"
        }.to_json
      end
    end
  end
end
