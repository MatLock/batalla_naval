Given(/^I visit mipagina$/) do
  visit '/mipagina'
end

When(/^I enter "(.*?)"$/) do |valor|
	fill_in(:nombre, :with => valor)
	click_button "boton_enviar"
end

Then(/^I want to see "(.*?)"$/) do |texto|
  expect(page.has_content?(texto)).to eq true
end