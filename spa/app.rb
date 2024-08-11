require 'sinatra'

get '/' do 
  File.open('views/index.html')
end
