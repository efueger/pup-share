require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:user)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

#   test "should get new" do
#     get :new
#     assert_response :success
#   end

#   test "should create user" do
#     assert_difference('User.count') do
#       post :create, user: { address: @user.address, building: @user.building, email: @user.email, emergency_phone: @user.emergency_phone, first_name: @user.first_name, last_name: @user.last_name, parent: @user.parent, phone: @user.phone, walker: @user.walker }
#     end

#     assert_redirected_to user_path(assigns(:user))
#   end

#   test "should show user" do
#     get :show, id: @user
#     assert_response :success
#   end

#   test "should get edit" do
#     get :edit, id: @user
#     assert_response :success
#   end

#   test "should update user" do
#     patch :update, id: @user, user: { address: @user.address, building: @user.building, email: @user.email, emergency_phone: @user.emergency_phone, first_name: @user.first_name, last_name: @user.last_name, parent: @user.parent, phone: @user.phone, walker: @user.walker }
#     assert_redirected_to user_path(assigns(:user))
#   end

#   test "should destroy user" do
#     assert_difference('User.count', -1) do
#       delete :destroy, id: @user
#     end

#     assert_redirected_to users_path
#   end
end
