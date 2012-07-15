require 'sinatra'
require 'data_mapper'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'sinatra/static_assets'
require 'will_paginate'
require 'will_paginate/data_mapper'  # or data_mapper/sequel

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:///#{Dir.pwd}/pinn.db")

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
  property :created_at, DateTime  
  property :updated_at, DateTime  
end

DataMapper.finalize.auto_upgrade!


get '/' do
  @products = Product.all(:order => [:created_at.desc], :conditions => {:category => "cars"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/freebies' do
  @products = Product.all(:order => [:created_at.desc], :conditions => {:category => "freebies"}).paginate(:page => params[:page], :per_page => 30)
  erb :freebies
end

get '/electronics' do
  @products = Product.all(:order => [:created_at.desc], :conditions => {:category => "electronics"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/makeitems/:cat' do
  if params[:cat] == "cars"
    url = "http://sfbay.craigslist.org/cto/"
  elsif params[:cat] == "electronics"
    url = "http://sfbay.craigslist.org/ela/"
  elsif params[:cat] == "freebies"
    puts "here"
    url = "http://sfbay.craigslist.org/zip/"
  else
    redirect '/'
  end

 # puts url
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
        if price == ""
          price = "FREE"
        end
        #puts price
        location = item.css('.itempn')[0].text.strip
        #puts location
        url = "#{item_link}"
        #sleep 2
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
          p.category = params[:cat]
          p.link = item_link
          p.price = price
          p.location = location
          p.img = img
          p.created_at = Time.now
          p.updated_at = Time.now
          p.save
            #p.errors.each do |error|
             # puts error
            #end
        end
    end
 
  redirect '/'
end
