require 'rails_helper'

feature 'Creating new job' do

  let (:user) { FactoryGirl.create(:user, password: 'lolololol', password_confirmation: 'lolololol') }

  scenario 'Creating a new job while not logged in' do
    visit root_path
    click_on 'New Job'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'creating a new job while logged in' do
    # log in
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully'
    # 
    visit root_path
    click_on 'New Job'
    expect(page).to have_content 'Create a pup to add to your job'
  end

  scenario 'Creating new job without pup' do
    # log in
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully'
    # 
    visit root_path
    click_on 'New Job'
    expect(page).to have_content 'Create a pup to add to your job'    
  end

  scenario 'Creating new job with pup' do
    # log in
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully'
    # create pup
    visit user_pups_path(user)
    expect(current_path).to eql(user_pups_path(user))
    click_on 'New Pup'
    expect(current_path).to eql(new_user_pup_path(user))
    fill_in 'Pup name', with: 'Ace'
    click_on 'Create Pup'
    expect(page).to have_content 'Pup created'
    expect(current_path).to eql(user_pups_path(user))
    # create job
    visit root_path
    expect(current_path).to eql(root_path)
    click_on 'New Job'
    expect(current_path).to eql(new_job_path)
    choose "job_pup_id_#{Pup.last.id}"
    fill_in 'Drop off location', with: Time.now
    fill_in 'Pick up location', with: Time.now
    click_on 'Create Job'
    expect(page).to have_content 'Job created'
    expect(current_path).to eql(root_path)
  end
end
