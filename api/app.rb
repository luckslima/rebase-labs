require 'sinatra'
require 'pg'
require 'rack/cors'
require 'sidekiq'
require_relative 'lib/tests'
require_relative 'lib/csv_importer'
require_relative 'lib/csv_import_worker'

set :bind, '0.0.0.0'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post]
  end
end

db_name = ENV['RACK_ENV'] == 'test' ? 'test_database' : 'my_database'

set :db_config, {
  dbname: db_name,
  user: 'postgres',
  password: 'password',
  host: 'db'
}

def db_connection
  @db_connection ||= PG.connect(settings.db_config)
end

post '/import' do
  if params[:file] && params[:file][:tempfile]
    tempfile = params[:file][:tempfile]
    filename = params[:file][:filename]
    permanent_path = "./uploads/#{filename}"
    
    FileUtils.mkdir_p('./uploads')
    
    File.open(permanent_path, 'wb') do |f|
      f.write(tempfile.read)
    end

    CSVImportWorker.perform_async(permanent_path)
    status 200
    body 'Importação iniciada em background!'
  else
    status 400
    body 'Arquivo CSV não encontrado'
  end
end

get '/tests' do
  content_type :json
  tests = Tests.new(db_connection)
  all_tests = tests.all
  all_tests.to_json
end

get '/tests/:token' do
  tests = Tests.new(db_connection)
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