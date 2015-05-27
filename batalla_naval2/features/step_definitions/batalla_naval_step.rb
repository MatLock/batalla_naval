require_relative '../../app/models/Tablero.rb'
require_relative '../../app/models/Barco.rb'
require_relative '../../app/models/Exceptions.rb'
require_relative '../../app/models/BarcoYaExistenteException.rb'
require 'uri'
require 'cgi'


Given(/^a board with dimensions "(.*?)" x "(.*?)"$/) do |x, y|
  	#@tablero = Tablero.new(x.to_i,y.to_i)
  visit '/mipagina'
  fill_in(:ancho, :with => x)
  fill_in(:alto, :with => y)
  click_button "crearTablero"
end

Given(/^I create a small ship in position "(.*?)"$/) do |coord|
  #@tablero.ponerBarcoEn(coord,BarcoChico.new("Foxtrox"))
  fill_in(:coordenadas, :with => coord)
  fill_in(:nombreBarco, :with => "Foxtrox")
  fill_in(:tamanio, :with => "1")
  click_button "crearBarco"
end

Then(/^position "(.*?)" is not empty$/) do |coord|
  #@tablero.posicionVacia(coord).should eq false
  fill_in(:coord, :with => coord)
  click_button "pregunta"
  page.should have_content('false')
end

Then(/^position "(.*?)" is empty$/) do |coord|
  #@tablero.posicionVacia(coord).should be true
  fill_in(:coord, :with => coord)
  click_button "pregunta"
  page.should have_content('true')
end


Given(/^I create a large ship in position "(.*?)"$/) do |coords|
  #@tablero.ponerBarcoEn(coords,BarcoLargo.new("Delta",2))
  fill_in(:coordenadas, :with => coords)
  fill_in(:nombreBarco, :with => "Delta")
  fill_in(:tamanio, :with => "3")
  click_button "crearBarco"
end


Given(/^coloco un barco en la posicion "(.*?)"$/) do |coord|
  #	@tablero.ponerBarcoEn(coord,BarcoChico.new("Bravo"))
  #rescue FueraDelTableroException => @excepcion
  #end
  fill_in(:coordenadas, :with => coord)
  fill_in(:nombreBarco, :with => "Charlie")
  fill_in(:tamanio, :with => "1")
  click_button "crearBarco"
end

Then(/^un error de "(.*?)" debe ser lanzada$/) do |excepcion|
  #expect(@excepcion.to_s).to eq excepcion
  page.should have_content("No es posible colocar un barco fuera del mapa!!")
end


Given(/^coloco dos barcos en la posicion "(.*?)"$/) do |coord|
  #@tablero.ponerBarcoEn(coord,BarcoChico.new("Bravo"))
  #begin
  # @tablero.ponerBarcoEn(coord,BarcoChico.new("Bravo"))
  #rescue BarcoYaExistenteException => @excepcion2
  #end
  fill_in(:coordenadas, :with => coord)
  fill_in(:nombreBarco, :with => "Charlie")
  fill_in(:tamanio, :with => "1")
  click_button "crearBarco"
  fill_in(:coordenadas, :with => coord)
  fill_in(:nombreBarco, :with => "Charlie")
  fill_in(:tamanio, :with => "1")
  click_button "crearBarco"
end


Then(/^un error de "(.*?)" debe ser esperado$/) do |excepcion|
  #expect(@excepcion2.to_s).to eq excepcion
  page.should have_content("Ya existe un barco en la coordenada proporcionada!")
end

