# dsfghj?
require 'nokogiri'
require 'open-uri'
require 'playwright'
require 'json'
require 'date'


# require 'net/http' creo que no será tan necesario

class SenamhiScrapper

	attr_accessor :fecha
	attr_accessor :ubicacion
    attr_accessor :tmax
	attr_accessor :tmin
	attr_accessor :condiciones
	attr_accessor :precipitacion
	attr_accessor :humedad
	attr_accessor :fuente
	attr_accessor :doc

	def initialize(ubicacion="La Paz", fuente = 'senamhi')
		@fecha = Date.today
		@ubicacion = ubicacion
		@fuente = fuente 
	end

	def LoadExternData(url)
		puts "Obteniendo datos..."
		Playwright.create(playwright_cli_executable_path:'/home/jh/node_modules/.bin/playwright') do |playwright|
			playwright.chromium.launch(headless:false) do |browser|
				page = browser.new_page
				page.goto('https://senamhi.gob.bo/index.php/inicio', timeout:360000)
				# puts "pagina ida"
				# puts self.ubicacion == 'La Paz'
				# puts self.ubicacion
				unless self.ubicacion == 'La Paz'
					doc = Nokogiri::HTML(page.content)
					# puts "entrando al unless"
			        current_option = doc.css('span#estacion span').text
			        # puts current_option
			        # puts "ubicacion es #{self.ubicacion[:ubicacion]}"
			        # puts ubicacion
					page.locator('#selectDepartamento').select_option(value: "#{self.ubicacion}")
					# puts "tarija"
					page.wait_for_selector('span#estacion',state: 'visible', timeout: 3600000)
					# puts "selector de estacion visible"
					page.wait_for_function("document.querySelector('span#estacion').textContent !== '#{current_option}'", timeout: 3000000)
					# puts "comparacion"
				end

				# end
				page.get_by_test_id('span#fenomeno')
				html_content = page.content
				
				browser.close 

				return doc = Nokogiri::HTML(html_content)
			end
		end
	end

	def SetData(doc)
		self.fecha = Date.today
		self.tmax = doc.css('span#tmax').text
		self.tmin = doc.css('span#tmin').text
		self.condiciones = doc.css('span#fenomeno').text.downcase
		self.precipitacion = doc.css('span#pcpn').text
		self.humedad = 0
		self.fuente = 6
	end
end

