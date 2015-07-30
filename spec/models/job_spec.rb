require 'rails_helper'

describe Job do

  # validations

  it 'is valid with drop-off time, drop-off location, pick_up_time, pick_up_location, pup and user' do
    job = FactoryGirl.build(:job, pup_id: 1, user_id: 1)  
    expect(job).to be_valid
  end

  it 'is invalid without drop_off_time' do
    job = FactoryGirl.build(:job, pup_id: 1, user_id: 1, drop_off_time: nil)
    job.valid?
    expect(job.errors[:drop_off_time]).to include("can't be blank")
  end

  it 'is invalid without drop_off_location' do
    job = FactoryGirl.build(:job, pup_id: 1, user_id: 1, drop_off_location: nil)
    job.valid?
    expect(job.errors[:drop_off_location]).to include("can't be blank")    
  end

  it 'is invalid without pick_up_time' do
    job = FactoryGirl.build(:job, pup_id: 1, user_id: 1, pick_up_time: nil)
    job.valid?
    expect(job.errors[:pick_up_time]).to include("can't be blank") 
  end

  it 'is invalid without pick_up_location' do
    job = FactoryGirl.build(:job, pup_id: 1, user_id: 1, pick_up_location: nil)
    job.valid?
    expect(job.errors[:pick_up_location]).to include("can't be blank")     
  end

  it 'is invalid without pup_id' do
    job = FactoryGirl.build(:job, pup_id: nil, user_id: 1)
    job.valid?
    expect(job.errors[:pup_id]).to include("can't be blank")     
  end

  it 'is invalid without user_id' do
    job = FactoryGirl.build(:job, pup_id: 1, user_id: nil)
    job.valid?
    expect(job.errors[:user_id]).to include("can't be blank")     
  end

  # methods

  let(:job) { FactoryGirl.create(:job) }

  it '.hide makes hidden true' do
    job.hide
    expect(job.hidden).to be true
  end

end