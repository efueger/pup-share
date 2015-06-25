require 'test_helper'
require 'pry'

class JobsControllerTest < ActionController::TestCase

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  test 'should get new' do
    sign_in FactoryGirl.create(:user)
    get :new
    assert_response :success
    assert_not_nil assigns(:job)
  end

  test 'new should redirect if user not signed in' do
    get :new
    assert_response :redirect
  end

  test 'should show job' do
    job = FactoryGirl.create(:job)   
    get :show, id: job
    assert_response :success
  end

  test 'should create job' do
    sign_in FactoryGirl.create(:user)
    job = FactoryGirl.create(:job)
    assert_difference('Job.count') do
      post :create, job: {
        drop_off_location: job.drop_off_location, 
        drop_off_time: job.drop_off_time, 
        pick_up_location: job.pick_up_location, 
        pick_up_time: job.pick_up_time 
        }
    end
    assert_redirected_to root_path
  end

  test 'should get edit' do
    sign_in FactoryGirl.create(:user)
    job = FactoryGirl.create(:job)   
    get :edit, id: job
    assert_response :success
  end

  test 'should update job' do
    sign_in FactoryGirl.create(:user)
    job = FactoryGirl.create(:job)
    patch :update, id: job, job: { 
      drop_off_location: job.drop_off_location, 
      drop_off_time: job.drop_off_time, 
      pick_up_location: job.pick_up_location, 
      pick_up_time: job.pick_up_time 
      }
    assert_redirected_to root_path
  end

  test 'should destroy job' do
    sign_in FactoryGirl.create(:user)
    job = FactoryGirl.create(:job)    
    assert_difference('Job.count', -1) do
      delete :destroy, id: job
    end
    assert_redirected_to root_path
  end
  
  test 'walk_request redirects to root' do
    sign_in FactoryGirl.create(:user)
    pre_approved_job = FactoryGirl.create(:pre_approved_job)
    get :walk_request, id: pre_approved_job.id
    assert_equal 'Request email sent', flash[:notice]
    assert_redirected_to root_path
  end

  test 'approve_walk_request' do
    pre_approved_job = FactoryGirl.create(:pre_approved_job)
    get :approve_walk_request, id: pre_approved_job.id
    assert_equal 'You approved a walk request', flash[:notice]
    assert_redirected_to root_path    
  end

  test 'cancel_walk alerts and redirects to root' do
    pre_approved_job = FactoryGirl.create(:pre_approved_job)
    get :cancel_walk, id: pre_approved_job.id
    assert_equal 'Walk cancelled', flash[:alert] 
    assert_redirected_to root_path 
  end

  test 'approve_walk_request on nonexistent job alerts and redirects to root' do
    get :approve_walk_request, id: 9999
    assert_equal 'Job request was cancelled or job no longer exists', flash[:alert] 
    assert_redirected_to root_path    
  end

  test 'deny_walk_request on nonexistent job alerts and redirects to root' do
    get :deny_walk_request, id: 9999
    assert_equal 'Job request was cancelled or job no longer exists', flash[:alert] 
    assert_redirected_to root_path      
  end

  test 'cancel_walk on nonexistent job alerts and redirects to root' do
    get :cancel_walk, id: 9999
    assert_equal 'Job request was cancelled or job no longer exists', flash[:alert] 
    assert_redirected_to root_path
  end

  
end
