require 'sinatra'
require 'pg'
require_relative 'lib/tests'

set :bind, '0.0.0.0'

get '/tests' do
  content_type :json
  tests = Tests.new
  all_tests = tests.all
  all_tests.to_json
end

get '/' do
  'Hello, world!'
end