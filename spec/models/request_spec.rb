require 'rails_helper'

describe Request do

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

  it '.approve_walk_request updates status' do
    my_request.approve_walk_request
    expect(my_request.status).to eq 'approved' 
  end

  it '.deny_walk_request updates status' do
    my_request.deny_walk_request
    expect(my_request.status).to eq 'declined'
  end

  it '.deny_walk_request hides the request' do
    my_request.deny_walk_request
    expect(my_request.hidden).to eq true
  end

  it '.cancel_walk updates status' do
    my_request.cancel_walk
    expect(my_request.status).to eq 'cancelled'
  end

  it '.cancel_walk hides the request' do
    my_request.cancel_walk
    expect(my_request.hidden).to eq true
  end

end # describe Request 
