require 'rails_helper'

describe Pup do

  # validations

  let(:pup) { FactoryGirl.create(:pup) }

  it 'is valid with name' do
    expect(pup).to be_valid
  end

  it 'is invalid without name' do
    invalid_pup = FactoryGirl.build(:invalid_pup)
    invalid_pup.valid?
    expect(invalid_pup.errors[:pup_name]).to include("can't be blank")
  end

  # methods

  it '.hide makes hidden true' do
    pup.hide
    expect(pup.hidden).to be true
  end

end