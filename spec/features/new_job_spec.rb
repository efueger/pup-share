require 'rails_helper'

feature 'Creating new job' do

  let (:user) { FactoryGirl.create(:user) }

  scenario 'Creating new job without pup' do
    sign_in user # Search Devise sign in Capybara

  end


end
