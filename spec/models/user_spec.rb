require 'rails_helper'


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

  it 'is valid with an @amazon.com email' do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without an @amazon.com email' do
    user = FactoryGirl.build(:invalid_user)
    user.valid?
    expect(user.errors[:email]).to include("Email address must have @amazon domain")
  end

  #   it 'is valid with a first name'
  #   it 'is invalid without a first name'
  #   it 'is valid with a last name'
  #   it 'is invalid without a last name'
  #   it 'is valid with a building'
  #   it 'is invalid without a building'
  #   it 'is valid with an address'        # address can be its own model mapping building name to street address
  #   it 'is invalid without an address'   # address can be its own model mapping building name to street address
  #   it 'is valid with a phone number'
  #   it 'is invalid without a phone number'
  #   it 'is valid with an emergency phone'
  #   it 'is invalid without an emergency phone'
  #   it 'is valid with an email ending with @amazon.com'
  #   it 'is invalid without an email ending with @amazon.com'

  # methods

  let(:owner)    { FactoryGirl.create(:user) }
  let(:job1)     { FactoryGirl.create(:job, user_id: owner.id) }
  let(:request2) { FactoryGirl.create(:request, user_id: owner.id, job_id: job2.id)}  
  
  let(:walker)   { FactoryGirl.create(:user) }
  let(:job2)     { FactoryGirl.create(:job, user_id: walker.id) }
  let(:request1)  { FactoryGirl.create(:request, user_id: walker.id, job_id: job1.id)}

  before :each do
    walker.requests << request1
    owner.requests << request2
  end

  context '.walker_jobs' do

    it 'returns jobs assocaited with a user\'s requests' do
      expect(walker.walker_jobs).to eq ([job1])
    end

    it 'returns nothing with a user has no requests' do
      empty_walker = FactoryGirl.create(:user)
      expect(empty_walker.walker_jobs).to be_empty
    end
  end

  context '.all_my_jobs' do
    it 'returns all jobs a user is related to' do
      expect(owner.all_my_jobs).to eq ([job1,job2])
    end
  end
end