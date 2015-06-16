require 'pry'
require 'test_helper'

class JobTest < ActiveSupport::TestCase
  setup do
    @pup_owner = FactoryGirl.create(:pup_owner)
    @walker = FactoryGirl.create(:walker)
    @job = FactoryGirl.create(:job)
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
  
#   test 'should send email' do
#     @job.walk_request(@walker)
#     @job.send_walk_request_mailer
#     binding.pry
#     assert_equal 1, ActionMailer::Base.deliveries.count 
#     assert_equal
#   end
  
  
  
  

end
