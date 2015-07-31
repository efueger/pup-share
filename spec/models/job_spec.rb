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

  let(:user) { FactoryGirl.create(:user) }
  let(:job)  { FactoryGirl.create(:job, actual_walker_id: user.id) }
  let(:pup)  { FactoryGirl.create(:pup, job_id: job.id, user_id: user.id) }

  it '.hide makes hidden true' do
    job.hide
    expect(job.hidden).to be true
  end

  context '.update_follow_up_attr' do
    it 'updates the job' do
      job.update_follow_up_attr('awesome')
      expect(job).to have_attributes(how_did_it_go: 'awesome', hidden: true)
    end

    it 'increments the actual walker\'s walks completed count' do
      expect { job.update_follow_up_attr('awesome') }.to change{User.find(job.actual_walker_id).walks_completed}.from(0).to(1)
    end

    it 'increments the pup walk completed count' do
      expect { job.update_follow_up_attr('awesome') }.to change{job.pup.walks_completed}.from(0).to(1)
    end

    it 'incrments the actual walker awesome count' do
      expect { job.update_follow_up_attr('awesome') }.to change{User.find(job.actual_walker_id).awesome_count}.from(0).to(1)   
    end

    it 'incrments the actual walker not_good_count' do
      expect { job.update_follow_up_attr('not_good') }.to change{User.find(job.actual_walker_id).not_good_count}.from(0).to(1)   
    end

    it 'incrments the actual walker no_show count' do
      expect { job.update_follow_up_attr('no_show') }.to change{User.find(job.actual_walker_id).no_show_count}.from(0).to(1)   
    end

    it 'returns a notice' do
      expect(job.update_follow_up_attr('awesome')).to eq 'Feedback recorded'
    end 
  end # update_follow_up_attr

end