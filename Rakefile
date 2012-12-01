require 'rake'
require 'data_mapper'
require 'dm-core'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'active_support/all'

DataMapper.setup(:default, "postgres://snicksnaps:secret@localhost/snicksnaps_production" || "sqlite:///#{Dir.pwd}/pinn.db")

# DataObjects::Postgres::Connection.class_eval do
#    def self.pool_size
#      1
#    end
# end
# DataObjects::Pooling.pools.each do |pool|
#   pool.dispose
# end

# puts "here"


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


  #DataMapper.repository(:default).adapter.send(:open_connection).dispose
  #DataMapper.setup(:default, postgresql_conn )

  def run_scrapper(category, url, city)
    # DataObjects::Pooling.pools.each do |pool|
    #   puts pool
    #   exit
    #   pool.dispose
    # end
    # if category == "cars"
    #   url = "http://sfbay.craigslist.org/cto/"
    # elsif category == "electronics"
    #   url = "http://sfbay.craigslist.org/ela/"
    # elsif category == "freebies"
    #   url = "http://sfbay.craigslist.org/zip/"
    # else
    #   puts "error not running SCRAPPER"
    # end
    #Product.all(:conditions => {:city => city, :created_at.gt => 1.week.ago, :category => category }).destroy
    #d_products = Product.all(:conditions => {:city => city, :created_at.lt => 1.day.ago, :category => category })
    #d_products.destroy
    doc = Nokogiri::HTML(open(url, 'User-Agent' => 'ruby'))

    doc.css(".row").each do |item|
    #puts item
    #puts item.at_css('')
    #links =  item.css("a")
    #puts links[0].text
    #puts item.at_css('.itempx')
    #puts links[0]["href"]
    #puts item.at_css('.itempx').css('.p').text
    #puts "hello"
      if item.at_css('.itempx').css('.p').text != ""
          link =  item.css("a")
          title =  link[0].text.strip
          item_link = link[0]["href"].strip

          if (item.css('.itempp')[0] != nil )
            price = item.css('.itempp')[0].text.strip
          else
            price = "0.00"
          end
          if price == ""
            price = "FREE"
          end
          #puts "end price"
          location = item.css('.itempn')[0].text.strip
          #puts location
          url = "#{item_link}"
          sleep 1
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
            puts title
            puts city.to_s
            puts category.to_s
            p = Product.new
            p.title = title.to_s
            p.description = description.to_s
            p.category = category.to_s
            p.link = item_link.to_s
            p.price = price.to_s
            p.location = location.to_s
            p.city = city.to_s
            p.img = img.to_s
            p.created_at = Time.now
            p.updated_at = Time.now
            #p.save
            if(p.save)
                puts "saved"
            else
              p.errors.each do |e|
                  puts e
              end
            end
          end
      end
    end

cities = ['newyork','lasvegas', 'losangeles', 'seattle','sandiego','chicago', 'miami',
          'sfbay', 'tampa', 'atlanta', 'dallas', 'minneapolis', 'boston',
          'sacramento', 'austin', 'washingtondc', 'phoenix', 'hartford', 'binghamton']

#cities.shuffle

cities.each do |city|

      if(city == 'sfbay')
        city_d =  'san-francisco-bay'
      elsif city == 'losangeles'
        city_d = 'los-angeles'
      elsif city == 'washingtondc'
        city_d = 'washington-dc'
      elsif city == 'sandiego'
        city_d = 'san-diego'
      elsif city == 'newyork'
        city_d = 'new-york'
      elsif city == 'lasvegas'
        city_d = 'las-vegas'
      else
        city_d = city
      end
      run_scrapper("cars", "http://#{city}.craigslist.org/cto/", city_d)
      sleep 20
      run_scrapper("electronics", "http://#{city}.craigslist.org/ela/", city_d)
      sleep 20
      run_scrapper("freebies", "http://#{city}.craigslist.org/zip/", city_d)
      sleep 20
      run_scrapper("activities", "http://#{city}.craigslist.org/act/", city_d)
      sleep 20
      run_scrapper("beautyservices", "http://#{city}.craigslist.org/bts/", city_d)
      run_scrapper("computers", "http://#{city}.craigslist.org/cps/", city_d)
      run_scrapper("events", "http://#{city}.craigslist.org/evs/", city_d)
      sleep 20
      run_scrapper("furniture", "http://#{city}.craigslist.org/fua/", city_d)
      sleep 20
      run_scrapper("computers", "http://#{city}.craigslist.org/cps/", city_d)
      run_scrapper("events", "http://#{city}.craigslist.org/evs/", city_d)
      sleep 20
      run_scrapper("housing", "http://#{city}.craigslist.org/hhh/", city_d)
      run_scrapper("jobs", "http://#{city}.craigslist.org/jjj/", city_d)
      run_scrapper("parking", "http://#{city}.craigslist.org/prk/", city_d)
      run_scrapper("sporting", "http://#{city}.craigslist.org/sga/", city_d)
      sleep 20
      run_scrapper("appliances", "http://#{city}.craigslist.org/ppa/", city_d)
      sleep 20
      run_scrapper("antiques", "http://#{city}.craigslist.org/ata/", city_d)
      sleep 20
      run_scrapper("barter", "http://#{city}.craigslist.org/bar/", city_d)
      sleep 20
      run_scrapper("bikes", "http://#{city}.craigslist.org/bia/", city_d)
      sleep 20
      run_scrapper("boats", "http://#{city}.craigslist.org/boo/", city_d)
      sleep 20
      run_scrapper("books", "http://#{city}.craigslist.org/bka/", city_d)
      sleep 20
      run_scrapper("business", "http://#{city}.craigslist.org/bfa/", city_d)
      sleep 20
      run_scrapper("general", "http://#{city}.craigslist.org/foa/", city_d)
      sleep 20
      run_scrapper("jewelry", "http://#{city}.craigslist.org/vga/", city_d)
      sleep 20
      run_scrapper("materials", "http://#{city}.craigslist.org/ppa/", city_d)
      sleep 20
      run_scrapper("rvs", "http://#{city}.craigslist.org/rva/", city_d)
      sleep 20
      run_scrapper("tickets", "http://#{city}.craigslist.org/tia/", city_d)
      sleep 20
      run_scrapper("tools", "http://#{city}.craigslist.org/tla/", city_d)
      sleep 20
      run_scrapper("wanted", "http://#{city}.craigslist.org/wan/", city_d)
      sleep 20
      run_scrapper("artscrafts", "http://#{city}.craigslist.org/ara/", city_d)
      sleep 20
      run_scrapper("autoparts", "http://#{city}.craigslist.org/pta/", city_d)
      sleep 20
      run_scrapper("babykids", "http://#{city}.craigslist.org/baa/", city_d)
      sleep 20
      run_scrapper("beautyhlth", "http://#{city}.craigslist.org/haa/", city_d)
      sleep 20
      run_scrapper("cdsdvdvhs", "http://#{city}.craigslist.org/ema/", city_d)
      sleep 20
      run_scrapper("cellphones", "http://#{city}.craigslist.org/moa/", city_d)
      sleep 20
      run_scrapper("clothsacc", "http://#{city}.craigslist.org/cla/", city_d)
      sleep 20
      run_scrapper("collectibles", "http://#{city}.craigslist.org/cba/", city_d)
      sleep 20
      run_scrapper("farmgarden", "http://#{city}.craigslist.org/gra/", city_d)
      sleep 20
      run_scrapper("garagesale", "http://#{city}.craigslist.org/hsa/", city_d)
      sleep 20
      run_scrapper("household", "http://#{city}.craigslist.org/vga/", city_d)
      sleep 20
      run_scrapper("motorcycles", "http://#{city}.craigslist.org/mca/", city_d)
      sleep 20
      run_scrapper("musicinstr", "http://#{city}.craigslist.org/msa/", city_d)
      sleep 20
      run_scrapper("photovideo", "http://#{city}.craigslist.org/pha/", city_d)
      sleep 20
      run_scrapper("toysgames", "http://#{city}.craigslist.org/taa/", city_d)
      sleep 20
end
