require 'rails_helper'

describe  WalkRequest do

  let(:user)               { FactoryGirl.create(:user) }
  let(:requested_of_user)  { FactoryGirl.create(:user) }
  let(:job)                { FactoryGirl.create(:job)  }

  describe 'walk_request' do

    let(:walk_request) { FactoryGirl.create(:request, user_id: user.id, 
      requested_of_user_id: requested_of_user.id, job_id: job.id, status: 'pending') }

    before :each do
      walk_request.send_request_mailers
    end

    let(:delivered_emails) { ActionMailer::Base.deliveries }

    # it 'delivers two emails' do
    it 'delivers one email' do
      expect(delivered_emails.count).to eq(1)
    end

    context 'request' do
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

    #     context 'request confirmation' do
    #       let(:confirm_email) { delivered_emails[1] }
    #       it 'delivered from the default' do
    #         expect(confirm_email).to be_delivered_from 'no-reply@PupShare.com'
    #       end

    #       it 'delivered to the requested_by user' do
    #         expect(confirm_email).to be_delivered_to user.email 
    #       end

    #       it 'has the expected subject' do
    #         expect(confirm_email).to have_subject 'PupShare: Confirmation: You submitted a walk request'  
    #       end
    #     end
  end # walk_request
  ########################################################
  ########################################################
  ########################################################

  describe 'approved request' do

    let(:walk_request) { FactoryGirl.create(:request, user_id: user.id, 
      requested_of_user_id: requested_of_user.id, job_id: job.id, status: 'approved') }

    before :each do
      walk_request.send_request_mailers
    end

    let(:delivered_emails) { ActionMailer::Base.deliveries }

    # it 'delivers two emails' do
    it 'delivers one email' do
      expect(delivered_emails.count).to eq(1)
    end

    context 'approval' do
      let(:approved_email) { delivered_emails.first }

      it 'delivered from the default' do
        expect(approved_email).to be_delivered_from 'no-reply@PupShare.com'
      end

      it 'delivered to the requesting user' do
        expect(approved_email).to be_delivered_to user.email 
      end

      it 'has the expected subject' do
        expect(approved_email).to have_subject 'PupShare: Yay! Your walk request was approved'   
      end
    end

    #     context 'approval confirmation' do
    #       let(:confirm_email) { delivered_emails[1] }

    #       it 'delivered from the default' do
    #         expect(confirm_email).to be_delivered_from 'no-reply@PupShare.com'
    #       end

    #       it 'delivered to the requested_of user' do
    #         expect(confirm_email).to be_delivered_to requested_of_user.email 
    #       end

    #       it 'has the expected subject' do
    #         expect(confirm_email).to have_subject 'PupShare: Confirmation: You approved a walk request'   
    #       end
    #     end
  end # approved request
  ########################################################
  ########################################################
  ########################################################

  describe 'declined request' do

    let(:walk_request) { FactoryGirl.create(:request, user_id: user.id, 
      requested_of_user_id: requested_of_user.id, job_id: job.id, status: 'declined') }

    before :each do
      walk_request.send_request_mailers
    end

    let(:delivered_emails) { ActionMailer::Base.deliveries }

    # it 'delivers two emails' do
    it 'delivers one email' do
      expect(delivered_emails.count).to eq(1)
    end

    context 'denied' do
      let(:denied_email) { delivered_emails.first }

      it 'delivered from the default' do
        expect(denied_email).to be_delivered_from 'no-reply@PupShare.com'
      end

      it 'delivered to the requesting user' do
        expect(denied_email).to be_delivered_to user.email 
      end

      it 'has the expected subject' do
        expect(denied_email).to have_subject 'PupShare: Sorry. Your walk request was denied'  
      end
    end

#     context 'denied confirmation' do
#       let(:confirm_email) { delivered_emails[1] }

#       it 'delivered from the default' do
#         expect(confirm_email).to be_delivered_from 'no-reply@PupShare.com'
#       end

#       it 'delivered to the requested_of user' do
#         expect(confirm_email).to be_delivered_to requested_of_user.email 
#       end

#       it 'has the expected subject' do
#         expect(confirm_email).to have_subject 'PupShare: Confirmation: You declined a walk request'    
#       end
#     end
  end # declined request
  ########################################################
  ########################################################
  ########################################################

  describe 'cancelled request' do

    let(:walk_request) { FactoryGirl.create(:request, user_id: user.id, 
      requested_of_user_id: requested_of_user.id, job_id: job.id, status: 'cancelled') }

    before :each do
      walk_request.send_request_mailers
    end

    let(:delivered_emails) { ActionMailer::Base.deliveries }

    it 'delivers one email' do
      expect(delivered_emails.count).to eq(1)
    end

    let(:cancel_email) { delivered_emails.first }

    it 'delivers from the default' do
      expect(cancel_email).to be_delivered_from 'no-reply@PupShare.com'
    end

    it 'delivers to both users' do
      expect(cancel_email).to be_delivered_to [user.email, requested_of_user.email]
    end

    it 'has the expected subject' do
      expect(cancel_email).to have_subject 'PupShare: Request cancelled notification' 
    end
  end # cancelled request
  ########################################################
  ########################################################
  ########################################################

  describe 'destroyed job' do

    let(:walk_request) { FactoryGirl.create(:request, user_id: user.id, 
      requested_of_user_id: requested_of_user.id, job_id: job.id, status: nil ) }

    before :each do
      walk_request.send_request_mailers
    end

    let(:delivered_emails) { ActionMailer::Base.deliveries }

    it 'delivers one email' do
      expect(delivered_emails.count).to eq(1)
    end

    let(:destroy_email) { delivered_emails.first }

    it 'delivered from the default' do
      expect(destroy_email).to be_delivered_from 'no-reply@PupShare.com'
    end

    it 'delivers to both users' do
      expect(destroy_email).to be_delivered_to [user.email, requested_of_user.email]
    end

    it 'has the expected subject' do
      expect(destroy_email).to have_subject 'PupShare: Walk removed by owner' 
    end
  end # destroyed job

end