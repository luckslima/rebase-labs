require 'spec_helper'
require 'rack/test'
require_relative '../../app'

ENV['RACK_ENV'] = 'test'

RSpec.describe 'Tests API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET /tests' do
    it 'returns all tests grouped by token' do
      get '/tests'
      expect(last_response).to be_ok
      json_response = JSON.parse(last_response.body)

      expect(json_response).to be_an_instance_of(Array)
      expect(json_response.first).to have_key("result_token")
      expect(json_response.first).to have_key("doctor")
      expect(json_response.first["doctor"]).to have_key("crm")
    end
  end

  describe 'GET /tests/:token' do
    it 'returns a specific test by token' do
      token = 'IQCZ17'
      get "/tests/#{token}"
      expect(last_response).to be_ok
      json_response = JSON.parse(last_response.body)

      expect(json_response).to have_key("result_token")
      expect(json_response["result_token"]).to eq(token)
      expect(json_response).to have_key("doctor")
      expect(json_response["doctor"]).to have_key("crm")
    end

    it 'returns 404 for a non-existent token' do
      token = 'nonexistent'
      get "/tests/#{token}"
      expect(last_response.status).to eq(404)
      json_response = JSON.parse(last_response.body)
      
      expect(json_response).to have_key("error")
      expect(json_response["error"]).to eq("Exame não encontrado")
    end
  end
end
