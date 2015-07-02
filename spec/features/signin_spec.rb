require 'rails_helper'

feature 'Signing in' do

  let :user do 
    FactoryGirl.create(:user, password: 'lolololol', password_confirmation: 'lolololol')
  end

  scenario 'Signing in with correct credentials' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'Signing in with bad credentials' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'booger' # incorrect
    click_on 'Log in'
    expect(page).to have_content 'Invalid email or password'
  end

end