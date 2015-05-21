require 'test_helper'

class PupsControllerTest < ActionController::TestCase
  setup do
    @pup = pups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pup" do
    assert_difference('Pup.count') do
      post :create, pup: { birthday: @pup.birthday, breed: @pup.breed, care_instructions: @pup.care_instructions, gender: @pup.gender, good_w_dogs: @pup.good_w_dogs, name: @pup.name, neutered: @pup.neutered, picture: @pup.picture, special_requirements: @pup.special_requirements, tracking_chip: @pup.tracking_chip, vet_phone: @pup.vet_phone, weight: @pup.weight }
    end

    assert_redirected_to pup_path(assigns(:pup))
  end

  test "should show pup" do
    get :show, id: @pup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pup
    assert_response :success
  end

  test "should update pup" do
    patch :update, id: @pup, pup: { birthday: @pup.birthday, breed: @pup.breed, care_instructions: @pup.care_instructions, gender: @pup.gender, good_w_dogs: @pup.good_w_dogs, name: @pup.name, neutered: @pup.neutered, picture: @pup.picture, special_requirements: @pup.special_requirements, tracking_chip: @pup.tracking_chip, vet_phone: @pup.vet_phone, weight: @pup.weight }
    assert_redirected_to pup_path(assigns(:pup))
  end

  test "should destroy pup" do
    assert_difference('Pup.count', -1) do
      delete :destroy, id: @pup
    end

    assert_redirected_to pups_path
  end
end
