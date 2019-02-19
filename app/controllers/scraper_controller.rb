class ScraperController < ApplicationController
  require 'openssl'
  require 'nokogiri'
  require 'open-uri'

  def scrape
    url = "https://us.banggood.com/Wholesale-Warehouse-1-wp-Usa-1227976.html?akmClientCountry=VN&rmmds=DSdownloadcenter"
    doc = Nokogiri::HTML(open(url))
    byebug
    title = doc.css('div.pro_attr_box table tr[2] td li[3] img').attr('title').value
    # pace.doc.at_css('#idLinkProductMainImage img').attr('src')
    # refer https://medium.com/@inanbunyamin90/using-capybara-for-scraping-9b078773c7c2
  end
end
