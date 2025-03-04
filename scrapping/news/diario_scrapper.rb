require "nokogiri"
require "date"
require "open-uri"
require_relative "base"

class DiarioScrapper < Noticia

	def initialize(fecha=Date.today.to_s.gsub('-', '/'), fuente='El Diario')
		self.fecha = fecha
		self.fuente = fuente
		@secciones = 'https://www.eldiario.net/portal/category/secciones/'
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

	def get_list(url="https://www.eldiario.net/portal/#{self.fecha}", tdi=56)
		puts "obteniendo noticias de la url: #{url}"
		page = Nokogiri::HTML(URI.open(url))
		article_list = page.css("div#tdi_#{tdi} a")
		titulares = []
		article_list.each do |article|
			unless article.text == 'Ver más' or article.text == '' or article.text == 'vista'
				titulares.push({"titulo" => article.text, "url" => article[:href]})
			end
		end
		page_number = page.css('span.pages').text[-1].to_i

		if page_number > 1 && !url.include?('secciones')
			for i in 2...page_number
				url = "https://www.eldiario.net/portal/#{self.fecha}/page/#{i}"
				page = Nokogiri::HTML(URI.open(url))
				article_list = page.css("div#tdi_#{tdi} a")
				article_list.each do |article|
					unless article.text == 'Ver más' or article.text == '' or article.text == 'vista'
						titulares.push({"titulo" => article.text, "url" => article[:href]})
					end
				end
			end
		end
		puts "cantidad de titulares obtenidos: #{titulares.length}"
		return titulares
	end
	
	def get_incidentes
		titulares = self.get_list
		incidentes = []

		titulares.each do |titular|
			
			has_incidents = @dict.any? {|situacion| titular['titulo'].downcase.include?(situacion.downcase)}
			if has_incidents
				incidentes.push(titular)
			end
		end

		return incidentes
	end

	def get_list_economia
		get_list(@secciones+'economia',58)
	end

	def get_list_nacional
		get_list(@secciones+'nacional',58)
	end

	def get_list_internacional
		get_list(@secciones+'internacional',58)
	end

	def get_list_seguridad
		get_list(@secciones+'seguridad',58)
	end

	def get_list_deportes
		get_list(@secciones+'deportes',58)
	end

end

prueba = DiarioScrapper.new
puts prueba.get_list_politica