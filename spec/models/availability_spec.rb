require 'rails_helper'

describe Availability do

  # validations
  
  it 'is valid with available_from, available_to and location' do
    availability = FactoryGirl.build(:availability)
    expect(availability).to be_valid
  end

  it 'is invalid without available_from' do
    availability = FactoryGirl.build(:availability, available_from: nil)     
    availability.valid?
    expect(availability.errors[:available_from]).to include("can't be blank")
  end

  it 'is invalid without available_to' do
    availability = FactoryGirl.build(:availability, available_to: nil)     
    availability.valid?
    expect(availability.errors[:available_to]).to include("can't be blank")      
  end
  
  it 'is invalid without location' do
    availability = FactoryGirl.build(:availability, location: nil)     
    availability.valid?
    expect(availability.errors[:location]).to include("can't be blank")
  end

  # methods

end
