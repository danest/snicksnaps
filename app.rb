require 'sinatra'
require 'data_mapper'
require 'json'
require 'open-uri'
require 'sinatra/static_assets'
require 'will_paginate'
require 'will_paginate/data_mapper'  # or data_mapper/sequel

if ENV['VCAP_SERVICES'].nil?
  DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/pinn.db")
else
  require 'json'
  services = JSON.parse(ENV['VCAP_SERVICES'])
  postgresql_key = services.keys.select { |svc| svc =~ /postgresql/i }.first
  postgresql = services[postgresql_key].first['credentials']
  postgresql_conn = {:host => postgresql['hostname'], :port => postgresql['port'], :user => postgresql['user'], :password => postgresql['password'], :dbname => postgresql['name']}
  #connection = PG.connect(postgresql_conn)
  puts postgresql_conn
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

helpers do
  def city_name
    request.cookies['select_city'] ||= 'san-francisco-bay'
  end
end


get '/' do
  if request.cookies['select_city'] == nil
    puts "nothing here"
  end
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  puts request.cookies
  puts city
  puts "something goes here"
  redirect to("#{city}/all")
end

get '/:city/all' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "cars" }).paginate(:page => params[:page], :per_page => 30)
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

get '/:city/parking' do
  city = request.cookies['select_city'] ||= 'san-francisco-bay'
  @products = Product.all(:order => [:created_at.desc], :conditions => {:city => city, :category => "parking"}).paginate(:page => params[:page], :per_page => 30)
  erb :index
end

