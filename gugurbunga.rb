#require 'rubygems'
require 'sinatra'
require 'csv'
require 'haml'
require "active_record"

#ActiveRecord::Base.establish_connection(
# :adapter => "mysql",  
# :host => "localhost",  
# :database => "test1"  
#)

dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection dbconfig['production']


class Bunga < ActiveRecord::Base
end

get '/' do
  haml :index
end

post '/upload' do
  CSV::Reader.parse(params[:csv][:tempfile]) do |line|
    if !line[1].nil? && line[1].slice(0,5) == 'Bunga'
      month_year = Date.strptime(line[0], "%d/%m/%Y")
      bunga = Bunga.find(:first,:conditions=> ["date like :month_year",{:month_year=>"%"+month_year.to_s+"%"}])
      unless bunga.nil?
        @message =  "Data bunga untuk bulan "+line[0]+"sudah ada"
      else	
        bunga = line[3].gsub(".","").gsub(",",".")
        Bunga.create(:username=>"fuad",:date=>Date.strptime(line[0], "%d/%m/%Y"),:bunga=>bunga)
	@message = "Data berhasil ditambah"
      end
    end
  end
  haml :upload
end

get '/hello_world' do
  "Hello world, it's #{Time.now} at the server"
end

