#TODO insert to db

require 'csv'

CSV::Reader.parse(File.open("/home/fuad/download-april2010.csv",'r')) do |line|
  if !line[1].nil? && line[1].slice(0,5) == 'Bunga'	
    puts line[3]
  end
end
   
