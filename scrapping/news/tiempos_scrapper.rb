require 'date'
require 'nokogiri'
require 'open-uri'
require_relative 'base'

class TiemposScrapper < Noticia 

	def initialize(fecha=Date.today, fuente='Los Tiempos')
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
	end

	def get_list(rama)
		url = "https://www.lostiempos.com/#{rama}"
		page = Nokogiri::HTML(URI.open(url))
		article_list = page.css('div.view-content a')
		titulares = []
		article_list.each do |article|
			unless article.text == 'Ver más' or article.text == '' or article.text == 'vista' or article[:href].include?(rama) == false
				titulares.push({"titulo" => article.text, "url" => article[:href]})
			end
		end
		return titulares
	end

	def get_incidentes
		url = "https://www.lostiempos.com/ultimas-noticias"
		page = Nokogiri::HTML(URI.open(url))
		article_list = page.css('div.view.view-ultimas.view-id-ultimas.noticias-lt-block a')
		titulares = []
		article_list.each do |article|
			unless article.text == 'Ver más' or article.text == '' or article.text == 'vista' or article.text == 'siguiente'
				titulares.push({"titulo" => article.text, "url" => article[:href]})
			end
		end
		url = "https://www.lostiempos.com/ultimas-noticias?page=1"
		page = Nokogiri::HTML(URI.open(url))
		article_list = page.css('div.view.view-ultimas.view-id-ultimas.noticias-lt-block a')
		article_list.each do |article|
			unless article.text == 'Ver más' or article.text == '' or article.text == 'vista' or article.text == 'siguiente' or article.text == 'anterior'
				titulares.push({"titulo" => article.text, "url" => article[:href]})
			end
		end

		incidentes = []

		titulares.each do |titular|
			
			has_incidents = @dict.any? {|situacion| titular['titulo'].downcase.include?(situacion.downcase)}
			if has_incidents
				incidentes.push(titular)
			end
		end

		return incidentes
	end

	def get_deportes
		self.get_list('deportes')
	end

	def get_pais
		self.get_list('actualidad/pais')
	end

	def get_mundo
		self.get_list('actualidad/mundo')
	end

	def get_economia
		self.get_list('actualidad/economia')
	end

	def get_seguridad
		self.get_list('actualidad/seguridad')
	end
end

prueba = TiemposScrapper.new

puts prueba.get_incidentes