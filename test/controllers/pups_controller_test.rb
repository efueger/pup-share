require 'test_helper'
require 'pry'

class PupsControllerTest < ActionController::TestCase
  
  setup do
    @pup = FactoryGirl.create(:pup)
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  test 'should get index' do
    get :index, user_id: @user.id
    assert_response :success
    assert_not_nil assigns(:pups)
  end

  test 'should get new' do
    get :new, user_id: @user.id
    assert_response :success
  end

  test 'should show pup' do
    get :show, id: @pup.id, user_id: @user.id
    assert_response :success
  end

  test "should create pup" do
    assert_difference('Pup.count') do
      post :create, pup: { }, user_id: @user.id
    end
    assert_redirected_to user_pups_path(@user)
  end

  test "should get edit" do
    get :edit, id: @pup, user_id: @user.id
    assert_response :success
  end

  test "should update pup" do
    patch :update, id: @pup, pup: {  }, user_id: @user.id 
    assert_redirected_to user_pups_path(@user)
  end

  test "should destroy pup" do
    assert_difference('Pup.count', -1) do
      delete :destroy, id: @pup, user_id: @user.id
    end
    assert_redirected_to user_pups_path(@user)
  end
end
