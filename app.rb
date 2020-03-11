#nano twitter
require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require 'faker'
require 'activerecord-import'
require_relative 'services/user_service.rb'
require_relative 'services/helper_services.rb'
require 'json'

# app.rb
require 'sinatra'
require './models'

get '/' do
  "Hello Sinatra!"
end

# sign up： create a new user
post '/users/signup' do
	result = UserService.signup(params)
	status (result[:status])
	result[:body].to_json
	redirect '/'
end

post '/users/login' do
   result = UserService.login(params)
    status (result[:status])
    result[:body].to_json
end

