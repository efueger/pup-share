require 'test_helper'
require 'pry'

class WalkRequestTest < ActionMailer::TestCase

  setup do
    @walker    = FactoryGirl.create(:user)    
    @pup_owner = FactoryGirl.create(:user)
    @job       = FactoryGirl.create(:job, user: @pup_owner) 
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

  test 'walk_request_send_destroyed_mailer to pending walker' do 
    @job.walk_request_pending_user = @walker
    @job.user = @pup_owner
    email = @job.send_destroyed_walk_mailer  
    assert_not ActionMailer::Base.deliveries.empty?
    binding.pry
    assert_equal [@pup_owner.email, @walker.email], email.to
    assert_equal ['no-reply@pup-share.com'], email.from  
  end

  test 'walk_request_send_destroyed_mailer to walker' do
    @job.walker = @walker
    @job.user = @pup_owner
    email = @job.send_destroyed_walk_mailer
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal [@pup_owner.email, @walker.email], email.to
    assert_equal ['no-reply@pup-share.com'], email.from  
  end

  test 'walk_request_send_destroyed_mailer delivers nothin to nobody' do
    @job.walk_request_pending_user = nil
    @job.walker = nil
    @job.send_destroyed_walk_mailer
    assert ActionMailer::Base.deliveries.empty?
  end

end
