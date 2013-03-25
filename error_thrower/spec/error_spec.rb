require 'spec_helper'

feature 'Generate errors' do
  scenario 'in products_controller.rb' do
	visit products_path
  end
   
  scenario 'in users_controller.rb' do
	visit users_path
  end

  scenario 'in sales_controller.rb' do
	visit sales_path
  end

  scenario 'in flights_controller.rb' do
	visit flights_path
  end
end