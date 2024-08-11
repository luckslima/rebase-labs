require 'sinatra'
require 'pg'
require_relative 'lib/tests'
require 'rack/cors'

set :bind, '0.0.0.0'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post]
  end
end

get '/tests' do
  content_type :json
  tests = Tests.new
  all_tests = tests.all
  all_tests.to_json
end

get '/tests/:token' do
  tests = Tests.new
  test = tests.find_by_token(params[:token])
  if test
    content_type :json
    test.to_json
  else
    halt 404, { error: "Exame não encontrado" }.to_json
  end
end

get '/' do
  'Hello, world!'
end