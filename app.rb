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
  property :img, Text, :required => true
  property :price, Text, :required => true
  property :location, Text, :required => true
  property :created_at, DateTime  
  property :updated_at, DateTime  
end

DataMapper.finalize.auto_upgrade!


get '/' do
  @products = Product.paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/makeitems' do
  url = "http://sfbay.craigslist.org/cto/"
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
        sleep 2
        doc = Nokogiri::HTML(open(url, 'User-Agent' => 'ruby'))

        str =  doc.css('#userbody')[0].text
        # the comment with the images is int [1]
        str = str.split(/\<![ \r\n\t]*(--([^\-]|[\r\n]|-[^\-])*--[ \r\n\t]*)\>/)

        #puts description = str[0].strip

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
          p.link = item_link
          p.price = price
          p.location = location
          p.img = img
          p.created_at = Time.now
          p.updated_at = Time.now
          p.save
        end
    end
 
  redirect '/'
end
