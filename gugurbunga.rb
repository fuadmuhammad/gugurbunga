require 'rubygems'
require 'sinatra'
require 'csv'
require 'haml'

get '/' do
  haml :index
end

post '/upload' do
  puts "test"
  @testing = "testing"
  CSV::Reader.parse(params[:csv]) do |line|
    puts line
    if !line[1].nil? && line[1].slice(0,5) == 'Bunga'	
      puts line[3]
      @bunga = line[3]
    end
  end
  haml :upload
end

get '/hello_world' do
  "Hello world, it's #{Time.now} at the server"
end

