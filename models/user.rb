require 'bcrypt'
class User < ActiveRecord::Base
    include BCrypt
    # attr_accessor :password
    
    validates_presence_of :name
    validates_presence_of :email
    validates_length_of :password, minimum: 3

    def self.authenticate(user_email, password)
        user = find_by(email: user_email)
        if user.nil?
          return false
        else
          return user.password == password
        end
      end


    

  end