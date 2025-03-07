require "httparty"
require "date"
require "json"

require_relative "news/deber_scrapper"
require_relative "news/tiempos_scrapper"
require_relative "news/diario_scrapper"
require_relative "coin/coin_scrapper"

=begin
require_relative "climate/accu_scrapper"
=end
require_relative "climate/senamhi_scrapper"
class News
	
	def load_data
		@sports_news = []
		@world_news = []
		@economia_news = []
		@national_news = []
		@security_news = []
		@incidentes = []


		#importando desde el deber, yo se que el codigo aca será un desastre pero meh
		scrapper = DeberScrapper.new

		temp = scrapper.get_mundo
		self.placing(temp, @world_news)

		temp = scrapper.get_economia
		self.placing(temp, @economia_news)

		temp = scrapper.get_news
		self.placing(temp, @national_news)

		temp = scrapper.get_deportes
		self.placing(temp, @sports_news)

		#importando desde el diario
		scrapper = DiarioScrapper.new

		temp = scrapper.get_incidentes
		self.placing(temp, @incidentes)

		temp = scrapper.get_list_economia
		self.placing(temp, @economia_news)

		temp = scrapper.get_news
		self.placing(temp, @national_news)

		temp = scrapper.get_deportes
		self.placing(temp, @sports_news)

		temp = scrapper.get_internacional
		self.placing(temp, @world_news)

		temp = scrapper.get_seguridad
		self.placing(temp, @security_news)

		#desde los tiempos
		scrapper = TiemposScrapper.new

		temp = scrapper.get_mundo
		self.placing(temp, @world_news)

		temp = scrapper.get_economia
		self.placing(temp, @economia_news)

		temp = scrapper.get_news
		self.placing(temp, @national_news)

		temp = scrapper.get_deportes
		self.placing(temp, @sports_news)

		temp = scrapper.get_seguridad
		self.placing(temp, @security_news)

		temp = scrapper.get_incidentes
		self.placing(temp, @incidentes)

	end

	def save_data
		@local_url = 'http://localhost:2000/Tnoticias'

		#insertando noticias de deportes
		@fecha = Date.today

		  post_headers= { 
		    'Content-Type' => 'application/json',  
		    'Accept' => 'application/json'        
		}

		self.saving(@sports_news, 1)
		self.saving(@national_news, 2)
		self.saving(@world_news, 3)
		self.saving(@economia_news, 4)
		self.saving(@security_news, 5)


	end

	def placing(source, objective)
		source.each do |item|
			objective.push(item)
		end
	end

	def saving(source, id_tema)
		post_headers= { 
			'Content-Type' => 'application/json',
		    'Accept' => 'application/json'         
		}
		source.each do |noticia|
			datos = {
				id_fuente: noticia["id_fuente"],
				id_tema: id_tema,
				fecha: @fecha,
				titulo: noticia["titulo"],
				descripcion_noticia: noticia["url"]
			}


			response = HTTParty.post(@local_url, body: datos.to_json, headers: post_headers)
			puts response
		end

		post_headers= { 
			'Content-Type' => 'application/json',
		    'Accept' => 'application/json'         
		}
		@incidentes.each do |noticia|
			datos = {
				lugar: "",
				tipo: "incidente",
				descripcion_incidente: noticia["titulo"],
				fecha: Date.today,
				hora: '00:00',
				id_fuente: 2,
				url: noticia["url"]
			}


			

			response = HTTParty.post(@local_url, body: datos.to_json, headers: post_headers)
			puts response
		end

	end

end

class Coin
	def load_data
		scrapper = CoinScrapper.new
		data = {compra: scrapper.compra, venta: scrapper.venta}
		return data
	end


	def save_data
		id_fuente = 5
		id_moneda = 1

		post_headers= { 
			'Content-Type' => 'application/json',
		    'Accept' => 'application/json'         
		}

		data = self.load_data
		datos = {
			id_fuente: id_fuente,
			id_moneda: id_moneda,
			fecha: Date.today,
			venta: data[:venta].gsub(',', '.').to_f,
			compra: data[:compra].gsub(',', '.').to_f
		}
		@local_url='http://localhost:2000/Tdatosmonedas'
		puts @local_url

		response = HTTParty.post(@local_url, body: datos.to_json, headers: post_headers)
		puts response

	end
end

class Climate
	def initialize
	@departamentos = [
		'La Paz', 
		'Santa Cruz', 
		'Cochabamba', 
		'Oruro', 
		'Potosí', 
		'Tarija', 
		'Chuquisaca', 
		'Beni', 
		'Pando'
	]
	end
	
	def load_save_data
		@departamentos.each do |departamento|
			scrapper = SenamhiScrapper.new(departamento)
			scrapper.SetData(scrapper.LoadExternData("a"))
			id = @departamentos.index(departamento) + 1

			id_fuente = 6

			post_headers= { 
				'Content-Type' => 'application/json',
			    'Accept' => 'application/json'         
			}

			datos = {
				fecha: Date.today,
				id_ubicacion: id,
				t_max: scrapper.tmax,
				t_min: scrapper.tmin,
				condiciones: scrapper.condiciones,
				precipitacion: scrapper.precipitacion,
				humedad: scrapper.humedad,
				id_fuente: id_fuente
			}
			@local_url='http://localhost:2000/Tclimas'
			puts @local_url

			response = HTTParty.post(@local_url, body: datos.to_json, headers: post_headers)
			puts response
			
		end
	end
	
end

noti = News.new
noti.load_data
noti.save_data
coin = Coin.new
coin.load_data
coin.save_data
climate = Climate.new
climate.load_save_data