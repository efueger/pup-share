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
  # you could also move the creation of the user to a before(:all) block, to speed it up
  test 'walk_request updates a job to include the requester\'s user id' do
    job            = FactoryGirl.build(:job)
    walk_requester = FactoryGirl.create(:user)
    job.walk_request(walk_requester)
    assert_not job.walk_request_pending_user_id.nil?
  end
  
#   test 'walk_request send a walk_request mailer to the pup\'s owner and confirmation to the requester' do
#     job            = FactoryGirl.build(:job)
#     walk_requester = FactoryGirl.create(:user)
#     job.walk_request(walk_requester)
#     binding.pry
#     # assert_not ActionMailer::Base.deliveries.empty?
#     assert_equal ['me@example.com'], email.from
#     assert_equal ['friend@example.com'], email.to
#   end
  

end
