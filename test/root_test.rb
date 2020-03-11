ENV['APP_ENV'] = 'test'

require_relative '../app.rb'
require 'minitest/autorun'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "GET on /api/users/:id" do
  before do
    User.delete_all
    User.create(
      name: "paul",
      email: "paul@gmail.com",
      password: "foo",
      self_intro: "Student")
  end

  it "Should return user by name" do
    get '/api/users/paul'
    last_response.ok?
    #puts "#{last_response.body}"
    attributes = JSON.parse(last_response.body)
    _(attributes["name"]).must_equal "paul"
  end

  it "Should return users email too" do
    get '/api/users/paul'
    last_response.ok?
    attributes = JSON.parse(last_response.body)
    _(attributes["email"]).must_equal "paul@gmail.com"
  end
  
  it "Should not return password" do
    get '/api/users/paul'
    last_response.ok?
    attributes = JSON.parse(last_response.body)
    _(attributes.key?("password")).must_equal false
  end
end

describe "POST on /api/users" do
  it "Should create a user" do
    post '/api/users', {
      name: "manzi",
      email: "manzi@gmail.com",
      password: "lotus",
      self_intro: "Lotus CEO"}.to_json
    last_response.ok?
    get '/api/users/manzi'
    last_response.ok?
    attributes = JSON.parse(last_response.body)
    _(attributes["email"]).must_equal "manzi@gmail.com"
    _(attributes["name"]).must_equal "manzi"
    _(attributes["self_intro"]).must_equal "Lotus CEO"
  end
end

describe "DELETE on api/users/:name" do
  before do
    User.delete_all
    User.create(
      name: "julian",
      email: "julian@gmail.com",
      password: "foo",
      self_intro: "Student")
  end

  it "Should delete a user" do
    delete '/api/users/julian'
    last_response.ok?
    get '/api/users/julian'
    last_response.ok?
    attributes = JSON.parse(last_response.body)
    _(attributes.key?("name")).must_equal false
  end
end

describe "PUT /api/users/:name/validate" do
  before do
    User.delete_all
    User.create(
      name: "julian",
      email: "julian@gmail.com",
      password: "foo",
      self_intro: "Student")
  end

  it "Should validate a user" do
    post '/api/users/julian/validate', {
      name: "julian",
      email: "julian@gmail.com",
      password: "foo",
      self_intro: "Student"}.to_json
    _(last_response.ok?).must_equal true
  end
end

describe "POST /api/users/:id" do
  before do
    User.delete_all
    User.create(
      name: "julian",
      email: "julian@gmail.com",
      password: "foo",
      self_intro: "Student")
  end

  it "Should update a user" do
    get '/api/users/julian'
    last_response.ok?
    attributes = JSON.parse(last_response.body)
    id = attributes["id"]
    put '/api/users/'+id.to_s, {
      name: "julian",
      email: "anotheremail@gmail.com",
      password: "foo",
      self_intro: "Student"}.to_json
    last_response.ok?

    get '/api/users/julian'
    last_response.ok?
    attributes = JSON.parse(last_response.body)
    _(attributes["email"]).must_equal "anotheremail@gmail.com"
  end
end

