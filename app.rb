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
Dir["models/*.rb"].each {|file| require_relative file }

get '/' do
  @users = User.all
  erb :index
end

get '/api/users/:name' do
  content_type :json
  user = User.find_by(name: params[:name])
  if user.nil?
    status 404
    {}.to_json
  else
    status 200
    content = {name:user.name, email:user.email, self_intro:user.self_intro, id:user.id}
    # return content in json
    content.to_json
  end 
end

post '/api/users' do
  user = User.create(JSON.parse(request.body.read))
  status 200
end

delete '/api/users/:name' do
  user = User.find_by(name: params[:name])
  if user.nil?
    status 404
  else
    user.destroy
    status 200
  end
end

post '/api/users/:name/validate' do
  data = JSON.parse(request.body.read)
  user = User.find_by(name: params[:name]) 
  if user.password == data["password"] && user.name == data["name"] && user.self_intro == data["self_intro"] && user.email == data["email"]
    status 200
  else
    status 404
  end
end

put "/api/users/:id" do
  data = JSON.parse(request.body.read)
  user = User.find(params[:id])
  if user.nil?
    status 404
  else
    status 200
    user.update(data)
  end
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

