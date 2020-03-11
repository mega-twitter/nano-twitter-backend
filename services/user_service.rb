require_relative '../models/user.rb'
require 'json'
class UserService

    def self.signup(params)
        user = User.new(params)

        if user.save
            make_json(202, 0, "Signup success!")
        else
            make_json(403, 1, "Signup failed!")
        end
    end

    def self.login(params)
        if User.authenticate(params[:email], params[:password])
            user = User.find_by(email: params[:email])
            return make_json(202, 0, "Login success!", user)
        else
            return make_json(403, 1, "Username and password do not match!")
        end
    end


end
