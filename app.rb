#nano twitter
require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require 'faker'
require 'activerecord-import'
require_relative 'services/user_service.rb'
require_relative 'services/helper_services.rb'
require 'json'

get '/' do
    erb :home
end

get '/signup' do
	erb :signup
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

