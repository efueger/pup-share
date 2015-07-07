require 'rails_helper'

describe Request do

  before :each do
    @requested_by = FactoryGirl.create(:user)
    @requested_of = FactoryGirl.create(:user)
    @job = FactoryGirl.create(:job)
    @request = FactoryGirl.create(:request, user_id: @requested_by.id, requested_of_user_id: @requested_of.id, job_id: @job.id, status: 'pending')
  end

  context 'status is pending' do
    it 'notifies user request sent' do
      expect(@request.send_request_mailers).to eq 'Request submitted'
    end
  end

  context 'status is approved' do
    it 'notifies request approved' do
      @request.status = 'approved'
      expect(@request.send_request_mailers).to eq 'Request approved!'    
    end
  end

  context 'status is declined' do
    it 'notifies request declined' do
      @request.status = 'declined'
      expect(@request.send_request_mailers).to eq 'Request declined'
    end
  end

  context 'status is cancelled' do
    it 'notifies request cancelled' do
      @request.status = 'cancelled'
      expect(@request.send_request_mailers).to eq 'Request cancelled'    
    end
  end

  context 'status is nil' do
    it 'returns nil and is handled by by rescue' do
      @request.status = nil  
      expect(@request.send_request_mailers).to be_nil
    end
  end


end # describe Request 
