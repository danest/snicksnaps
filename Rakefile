
task :db do
	require 'nokogiri'
	require 'data_mapper'
  #require File.expand_path(File.join(*%w[ config environment ]), File.dirname(__FILE__))
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:///#{Dir.pwd}/pinn.db")
  DataMapper.finalize.auto_upgrade!
  url = "http://sfbay.craigslist.org/cto/"
  doc = Nokogiri::HTML(open(url, 'User-Agent' => 'ruby'))

end