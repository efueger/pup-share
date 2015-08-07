require 'rails_helper'

feature 'Visitor signs up' do

  scenario 'with VALID credentials' do
    sign_up_with 'macklemore@amazon.com', 'ryan_lewis'
    expect(page).to have_content 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
  end

  scenario 'with INVALID credentials' do
    sign_up_with nil, 'ryan_lewis'
    expect(page).to have_content "can't be blank"
  end

  def sign_up_with(email, password)
    visit new_user_registration_path
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button 'Sign up'
  end

end