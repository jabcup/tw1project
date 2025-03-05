require "date"
require "nokogiri"
require "open-uri"
require_relative "base"


class DeberScrapper < Noticia
	def initialize(fecha=Date.today.strftime("%d/%m/%y"), fuente="El Deber")
		self.fecha = fecha
		self.fuente = fuente
		@dict = [
					  # Paros/Huelgas
		  "paro", "huelga", "paralización", "conflicto laboral", 
		  "suspensión de actividades", "toma de instalaciones",
		  
		  # Bloqueos
		  "bloqueo", "corte de ruta", "cierre de carretera", 
		  "reten", "obstrucción vial", "barricada",
		  
		  # Protestas/Marchas
		  "marcha", "protesta", "manifestación", "concentración", 
		  "movilización", "cacerolazo", "protesta social",
		  
		  # Violencia
		  "enfrentamiento", "disturbios", "choques", "represión", 
		  "saqueos", "detenciones", "desalojo",
		  
		  # Efectos
		  "caos vial", "tráfico colapsado", "desabastecimiento", 
		  "comercios cerrados", "servicios suspendidos"
		].freeze
		@base_url = 'http://eldeber.com.bo/'
		@headers = {
		  "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36",
		  "Accept" => "text/html",
		  "Accept-Language" => "en-US,en;q=0.9"
		}
	end

	def get_list(section="ultimas-noticias/")
		url = @base_url + section
		puts "la url es: #{url}"
		page = Nokogiri::HTML(URI.open(url))
		puts "importado aparentemente"
		noticias = []
		article_list = page.css('div.view-content div.titulo-teaser-2col  a')
		article_list.each do |articulo|
			noticias.push({"titulo"=> articulo.text.gsub(/\s*\n              \n            \s*/, ' ').strip, "url"=>'https://eldeber.com.bo'+articulo[:href], "id_fuente"=>1})
		end
		return noticias
	end
	
	def get_last_news
		self.get_list()
	end

	def get_deportes
		self.get_list("sports/")
	end

	def get_mundo
		self.get_list("mundo/")
	end

	def get_economia
		self.get_list("economia/")
	end

	def get_news
		self.get_list("pais/")
	end
	
end
