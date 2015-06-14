require 'pry'
require 'test_helper'

class JobTest < ActiveSupport::TestCase

  # validations
  test 'job includes a DateTime drop off time' do
    job = FactoryGirl.build(:job)
    assert_not job.drop_off_time.nil?
    assert 'DateTime', job.drop_off_time.class
  end

  test 'job includes a drop off location' do
    job = FactoryGirl.build(:job)
    assert_not job.drop_off_time.nil?
    assert_not_equal 0, job.drop_off_location.size
  end

  test 'job includes a DateTime pick up time' do
    job = FactoryGirl.build(:job)
    assert_not job.pick_up_time.nil?
    assert 'DateTime', job.pick_up_time.class
  end

  test 'job includes a pick up location' do
    job = FactoryGirl.build(:job)
    assert_not job.pick_up_location.nil?
    assert_not_equal 0, job.pick_up_location.size
  end

  # methods
  # before_action to create job and confirmed user?
  test 'walk_request sets user id' do
    job    = FactoryGirl.build(:job)
    walker = FactoryGirl.create(:user)
    job.walk_request(walker)
    assert_not job.walk_request_pending_user_id.nil?
  end

  test 'approve_walk_request sets walker id and pending walker id to nil' do
    job    = FactoryGirl.build(:job)
    walker = FactoryGirl.create(:user)
    job.approve_walk_request(walker)
    assert job.walk_request_pending_user_id.nil?
    assert_not job.walker_id.nil?
  end

  test 'deny_walk_request sets pending walker id to nil' do
    job       = FactoryGirl.build(:job, walk_request_pending_user_id: 2)
    walker    = FactoryGirl.create(:user, id: 2)
    pup_owner = FactoryGirl.create(:user, email: 'brnt@gmail.com')
    job.deny_walk_request(pup_owner)
    assert job.walk_request_pending_user_id.nil?
  end

end
