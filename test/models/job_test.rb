require 'test_helper'
require 'pry'

class JobTest < ActiveSupport::TestCase

  setup do
    @job       = FactoryGirl.create(:job)    
    @pup_owner = FactoryGirl.create(:user)
    @walker    = FactoryGirl.create(:user)
  end

  # validations
  test 'job includes a DateTime drop off time' do
    assert_not @job.drop_off_time.nil?
    assert 'DateTime', @job.drop_off_time.class
  end

  test 'job includes a drop off location' do
    assert_not @job.drop_off_time.nil?
    assert_not_equal 0, @job.drop_off_location.size
  end

  test 'job includes a DateTime pick up time' do
    assert_not @job.pick_up_time.nil?
    assert 'DateTime', @job.pick_up_time.class
  end

  test 'job includes a pick up location' do
    assert_not @job.pick_up_location.nil?
    assert_not_equal 0, @job.pick_up_location.size
  end
  
  test 'job incldues pup' do
    assert_not @job.pup.nil?
  end

  # methods
  test 'walk_request sets user id' do
    @job.walk_request(@walker)
    assert_not @job.walk_request_pending_user_id.nil?
    assert @job.walk_request_pending_user_id.is_a? Numeric
  end

  test 'approve_walk_request sets pending walker id to nil and sets walker id' do
    @job.update walk_request_pending_user_id: @walker.id
    @job.approve_walk_request
    assert @job.walk_request_pending_user_id.nil?
    assert_not @job.walker_id.nil?
    assert @job.walker_id.is_a? Numeric
  end

  test 'deny_walk_request sets pending walker id to nil' do
    @job.deny_walk_request
    assert @job.walk_request_pending_user_id.nil?
  end

  test 'send_destroyed_walk_mailer mailer needs walker or pending walker ' do
    @job.walk_request_pending_user = @walker
    @job.send_destroyed_walk_mailer
    assert !@job.walker.nil? || !@job.walk_request_pending_user.nil? 
    # i.e. either of walker or pending walker is not nil
    # sort of a boring test b/c I need to assign a walker or pending walker first...
  end

end
