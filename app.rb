require 'sinatra'
require 'data_mapper'
require 'json'
require 'open-uri'
require 'xml-sitemap'
require 'sinatra/static_assets'
require 'will_paginate'
require 'will_paginate/data_mapper'  # or data_mapper/sequel

#DataMapper.setup(:default, "postgres://snicksnaps:secret@localhost/snicksnaps_production" || "sqlite:///#{Dir.pwd}/pinn.db")
DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/pinn.db" || "postgres://snicksnaps:secret@localhost/snicksnaps_production")

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


#DataMapper.auto_migrate!
DataMapper.finalize.auto_upgrade!

helpers do
  def city_name
    request.cookies['select_city'] ||= 'san-francisco-bay'
  end
end

get '/' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  redirect to("#{city}/all")
end


get '/:city/all' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "cars" }).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/cars' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "cars" }).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/parking' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "parking" }).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/freebies' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "freebies"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/electronics' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "electronics"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/activites' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "activities"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/appliances' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "appliances"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end



get '/:city/beauty' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "beautyservices"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/computer' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "computers"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/events' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "events"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/furniture' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "furniture"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/housing' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "housing"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/jobs' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "jobs"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/sporting' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "sporting"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/videogames' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "videogames"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/applicances' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "applicances"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/antiques' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "antiques"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/barter' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "barter"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/bikes' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "bikes"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/boats' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "boats"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/books' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "books"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/business' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "business"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/general' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "general"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/jewelry' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "jewelry"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/materials' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "materials"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/rvs' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "rvs"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/tickets' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "tickets"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/tools' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "tools"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/wanted' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "wanted"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/artsandcrafts' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "artscrafts"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/autoparts' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "autoparts"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/babyandkids' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "babykids"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/beautyhlth' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "beautyhlth"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/cdsdvdvhs' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "cdsdvdvhs"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end


get '/:city/cellphones' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "cellphones"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/clothsacc' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "clothsacc"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/collectibles' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "collectibles"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/farmandgarden' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "farmgarden"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/garagesale' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "garagesale"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/household' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "household"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/motorcycles' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "motorcycles"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/musicinstructor' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "musicinstr"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/photovideo' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "photovideo"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/:city/toysandgames' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "toysgames"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

get '/sitemap.xml' do
  map = XmlSitemap::Map.new('snicksnaps.com') do |m|
    m.add(:url => '/', :period => :weekly)
  end

  headers['Content-Type'] = 'text/xml'
  map.render
end

