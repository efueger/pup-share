require 'rails_helper'

describe Request do

  before :each do
    Delayed::Worker.delay_jobs = false
  end

  # validations

  # methods

  let(:job) { FactoryGirl.create(:job) }
  let(:user) { FactoryGirl.create(:user) } 
  let(:requested_of_user) { FactoryGirl.create(:user) } 
  let(:my_request) { FactoryGirl.create(:request, user_id: user.id,
    requested_of_user_id: requested_of_user.id, job_id: job.id) }

  it '.walk_request updates status' do
    my_request.walk_request
    expect(my_request.status).to eq 'pending' 
  end

  context '.approve_walk_request' do

    it 'updates job actual walker' do
      my_request.approve_walk_request
      expect(my_request.job).to have_attributes(actual_walker_id: user.id)
    end

    it 'updates request status' do
      my_request.approve_walk_request
      expect(my_request.status).to eq 'approved' 
    end

    it 'returns a notice' do
      expect(my_request.approve_walk_request).to eq 'Request approved'       
    end

  end # '.approve_walk_request'

  context '.deny_walk_request' do
    it 'updates status' do
      my_request.deny_walk_request
      expect(my_request.status).to eq 'declined'
    end

    it 'hides the request' do
      my_request.deny_walk_request
      expect(my_request.hidden).to eq true
    end

    it 'returns a notice' do
      expect(my_request.deny_walk_request).to eq 'Request declined'
    end
  end # '.deny_walk_request' 

  context '.cancel_walk' do
    it 'updates status' do
      my_request.cancel_walk
      expect(my_request.status).to eq 'cancelled'
    end

    it 'hides the request' do
      my_request.cancel_walk
      expect(my_request.hidden).to eq true
    end

    it 'returns a notice' do
      expect(my_request.cancel_walk).to eq 'Walk cancelled'
    end
  end # '.cancel_walk'

end # describe Request 