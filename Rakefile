require 'nokogiri'
require 'data_mapper'

task :db => :environment do
  #require File.expand_path(File.join(*%w[ config environment ]), File.dirname(__FILE__))

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
          p.link = item_link
          p.price = price
          p.location = location
          p.img = img
          p.created_at = Time.now
          p.updated_at = Time.now
          p.save
        end
    end
end