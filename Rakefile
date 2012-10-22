require 'sinatra'
require 'data_mapper'
require 'json'
require 'nokogiri'
require 'open-uri'
task :fetch do

if ENV['VCAP_SERVICES'].nil?
  DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/pinn.db")
else
  require 'json'
  services = JSON.parse(ENV['VCAP_SERVICES'])
  postgresql_key = services.keys.select { |svc| svc =~ /postgresql/i }.first
  postgresql = services[postgresql_key].first['credentials']
  #postgresql_conn = {:host => postgresql['hostname'], :port => postgresql['port'], :user => postgresql['user'], :password => postgresql['password'], :dbname => postgresql['name']}
  #connection = PG.connect(postgresql_conn)
  postgresql_conn = "postgres://"+postgresql['user']+":"+postgresql['password']+"@"+postgresql['host']+":"+postgresql['port'].to_s + " " + "/"+postgresql['name']
  postgresql_conn.gsub!(/\s+/, "")
  DataMapper.setup(:default, postgresql_conn )
end

class Product
  include DataMapper::Resource
  property :id, Serial
  property :title, Text, :unique => true
  property :link, Text, :required => true
  property :description, Text, :required => true
  property :category, Text, :required => true
  property :img, Text, :required => true
  property :price, Text, :required => true
  property :location, Text, :required => true
  property :city, Text, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

def run_scrapper(category)
  puts Time.now.getutc
  if category == "cars"
    url = "http://sfbay.craigslist.org/cto/"
  elsif category == "electronics"
    url = "http://sfbay.craigslist.org/ela/"
  elsif category == "freebies"
    url = "http://sfbay.craigslist.org/zip/"
  else
    puts "error not running SCRAPPER"
  end
  doc = Nokogiri::HTML(open(url, 'User-Agent' => 'ruby'))

  doc.css(".row").each do |item|
  #puts item.at_css('')
  #links =  item.css("a")
  #puts links[0].text
  #puts links[0]["href"]
    if item.at_css('.itempx').css('.p').text != ""
        link =  item.css("a")
        title =  link[0].text.strip
        #puts title
        item_link = link[0]["href"].strip

        price = item.css('.itempp')[0].text.strip
        #puts price
        location = item.css('.itempn')[0].text.strip
        #puts location
        url = "#{item_link}"
        sleep 1 #this is causing it to run slower
        doc = Nokogiri::HTML(open(url, 'User-Agent' => 'ruby'))

        str =  doc.css('#userbody')[0].text
        # the comment with the images is int [1]
        str = str.split(/\<![ \r\n\t]*(--([^\-]|[\r\n]|-[^\-])*--[ \r\n\t]*)\>/)

        description = str[0].strip

        images = ""
        img = ""

        if str[1].respond_to?(:split)
          images = str[1].split(/"(.*?)"/)
          img =  images[1].strip
          #puts img
        end
          p = Product.new
          p.title = title
          p.description = description
          p.category = category
          p.link = item_link
          p.price = price
          p.location = location
          p.city = "San-Francisco"
          p.img = img
          p.created_at = Time.now
          p.updated_at = Time.now
          p.save
        end
    end
  end
  run_scrapper("cars")
  puts "CARS SCRAPPER"
  run_scrapper("electronics")
  puts "ELECTORNICS SCRAPPER"
  run_scrapper("freebies")
  puts "FREEBIES SCRAPPER"
  puts "finished rake task"
  puts Time.now.getutc
end
