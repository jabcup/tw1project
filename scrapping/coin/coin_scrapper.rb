require 'nokogiri'
require 'open-uri'
require 'date'

class CoinScrapper
	attr_accessor :fecha
	attr_accessor :venta
	attr_accessor :compra

	def initialize()
		fecha = Date.today
		url = 'https://www.bcb.gob.bo'
		doc = Nokogiri::HTML(URI.open(url))
		self.venta = doc.css("div.col-sm-12.col-xs-12 > div:nth-child(2) > strong").text[0..3]
		self.compra = doc.css("div.col-sm-12.col-xs-12 > div:nth-child(2) > strong").text[4..]
	end
	
end
