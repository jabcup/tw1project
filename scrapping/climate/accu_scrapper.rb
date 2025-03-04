# lp cod e 33655

# scrapper para obtener los datos desde accuweather

require 'httparty'
require 'json'
require 'date'

api_key = 'nrjrerpGpnikyvKgAR5o31VKGMAVq2bt'
$key = "?apikey=#{api_key}"
$LKey = { 'La Paz' => '33655', 'Oruro' => '34377', 'Potosi' => '35114', 'Santa Cruz' => '36300', 'Beni' => '32769', 'Pando' => '34480', 'Cochabamba' => '32716', 'Chuquisaca' => '32544', 'Tarija' => '36802' }


class AccuScrapper
	attr_accessor :fecha
	attr_accessor :ubicacion
    attr_accessor :tmax
	attr_accessor :tmin
	attr_accessor :condiciones
	attr_accessor :precipitacion
	attr_accessor :humedad
	attr_accessor :fuente

	def initialize(ubicacion='La Paz')
		self.ubicacion = ubicacion
		self.fecha = Date.today
		self.fuente = 'AccuWeather'
	end
	
	def GetTodayForecast
		data = HTTParty.get("http://dataservice.accuweather.com/forecasts/v1/daily/1day/#{$LKey}/#{$key}&details=true&metric=true")
		data = JSON.parse(data.body)
		temp = data["DailyForecasts"][0]["Temperature"]
		self.tmin = temp["Minimum"]["Value"].round
		self.tmax = temp["Maximum"]["Value"].round
		self.precipitacion = data["DailyForecasts"][0]["Day"]["PrecipitationProbability"] # probabilidad de precipitacion
		condiciones = data["DailyForecasts"][0]["Day"]["IconPhrase"]
		self.condiciones = condiciones
		self.humedad = data["DailyForecasts"][0]["Day"]["RelativeHumidity"]["Average"] 
		
=begin
		puts "temperatura minima: #{self.tmin}"
		puts "Temperatura maxima: #{self.tmax}"
		puts "probabilidad de precipitacion: #{self.precipitacion}"
		puts "condiciones: #{self.condiciones}"
		puts "la humedad relativa es: #{self.humedad}"
=end	
	end
end


=begincoso = AccuScrapper.new()
coso.GetTodayForecast
=end


