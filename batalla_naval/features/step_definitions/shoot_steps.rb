require_relative '../../app/models/Board.rb'

Given(/^a board with dimension "(.*?)" x "(.*?)"$/) do |x, y|
  visit '/batalla'
  fill_in(:ancho, :with => x)
  fill_in(:alto, :with => y)
  click_button "armar_tablero"
end

Given(/^a large ship in position "(.*?)"$/) do |coord|
  fill_in(:coordenadas_agregar, :with => coord)
  choose("checkLargo")
  click_button "btnAgregarBarco"
end

Given(/^I shoot to position "(.*?)"$/) do |coord|
  fill_in(:coordToShoot, :with => coord)
  click_button "btnShoot"
end

Then(/^I get hit$/) do
   page.should have_content('HIT')
end

Then(/^I get water$/) do
  page.should have_content('WATER')
end

Then(/^I get sink$/) do
  page.should have_content('SINK')
end


