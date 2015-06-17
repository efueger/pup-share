require 'test_helper'
require 'pry'

class WalkRequestTest < ActionMailer::TestCase

  setup do
    @job       = FactoryGirl.create(:job)    
    @pup_owner = FactoryGirl.create(:pup_owner)
    @walker    = FactoryGirl.create(:walker)
    @job.walk_request(@walker) # a walk_request precedes every mailer    
  end

  test 'walk_request' do
    email = WalkRequest.walk_request(@job).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal [@walker.email], email.from
    assert_equal [@pup_owner.email], email.to
  end

  test 'walk_request_confirmation' do
    email = WalkRequest.walk_request_confirmation(@job).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal [@walker.email], email.to
    assert_equal ['no-reply@pup-share.com'], email.from    
  end

  test 'walk_request_approved' do
    email = WalkRequest.walk_request_approved(@job).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal [@walker.email], email.to
    assert_equal [@pup_owner.email], email.from   
  end
  
  test 'walk_request_approved_confirmation' do
    email = WalkRequest.walk_request_approved_confirmation(@job).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal [@pup_owner.email], email.to
    assert_equal ['no-reply@pup-share.com'], email.from      
  end
  
  test 'walk_request_denied' do
    email = WalkRequest.walk_request_denied(@job).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal [@walker.email], email.to
    assert_equal [@pup_owner.email], email.from      
  end
  
  test 'walk_request_denied_confirmation' do
    email = WalkRequest.walk_request_denied_confirmation(@job).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal [@pup_owner.email], email.to
    assert_equal ['no-reply@pup-share.com'], email.from       
  end
  
  test 'walk_request_cancel' do 
    email = WalkRequest.walk_request_cancel(@job).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal [@pup_owner.email, @walker.email], email.to
    assert_equal ['no-reply@pup-share.com'], email.from      
  end

end
