require 'rails_helper'
require 'pry'


describe User do
  
  # validations
  
  it 'is valid with an email' do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user = FactoryGirl.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include('can\'t be blank')
  end
  
  it 'is valid with a first name'
  it 'is invalid without a first name'
  it 'is valid with a last name'
  it 'is invalid without a last name'
  it 'is valid with a building'
  it 'is invalid without a building'
  it 'is valid with an address'        # address can be its own model mapping building name to street address
  it 'is invalid without an address'   # address can be its own model mapping building name to street address
  it 'is valid with a phone number'
  it 'is invalid without a phone number'
  it 'is valid with an emergency phone'
  it 'is invalid without an emergency phone'
  it 'is valid with an email ending with @amazon.com'
  it 'is invalid without an email ending with @amazon.com'

end