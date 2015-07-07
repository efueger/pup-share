require 'rails_helper'

describe  WalkRequest do

  describe 'walk_request' do

    let(:user)               { FactoryGirl.create(:user) }
    let(:requested_of_user)  { FactoryGirl.create(:user) }
    let(:job)                { FactoryGirl.create(:job)  }
    let(:walk_request)       { FactoryGirl.create(:request, user_id: user.id, 
      requested_of_user_id: requested_of_user.id, job_id: job.id, status: 'pending') }

    before :each do
      walk_request.send_request_mailers
    end

    let(:delivered_emails) { ActionMailer::Base.deliveries }

    it 'delivers two emails' do
      expect(delivered_emails.count).to eq(2)
    end

    context 'request to pup owner' do
      let(:request_email) { delivered_emails.first }

      it 'delivered from the default' do
        expect(request_email).to be_delivered_from 'no-reply@PupShare.com'
      end

      it 'delivered to the requested_of user' do
        expect(request_email).to be_delivered_to requested_of_user.email 
      end

      it 'has the expected subject' do
        expect(request_email).to have_subject 'PupShare: Please approve or deny a walk request'   
      end
    end

    context 'request confirmation' do
      let(:confirm_email) { delivered_emails[1] }
      it 'delivered from the default' do
        expect(confirm_email).to be_delivered_from 'no-reply@PupShare.com'
      end

      it 'delivered to the requested_by user' do
        expect(confirm_email).to be_delivered_to user.email 
      end

      it 'has the expected subject' do
        expect(confirm_email).to have_subject 'PupShare: Confirmation: You submitted a walk request'  
      end
    end
  end # walk_request


end