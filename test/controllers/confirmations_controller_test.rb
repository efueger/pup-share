require 'test_helper'
require 'pry'

class ConfirmationsControllerTest < ActionController::TestCase
  # include Devise::TestHelpers
  
  test 'after confirmation redirect to root' do
    user = FactoryGirl.create(:user, confirmed_at: nil)   
    user.confirmation_token = 'lol'q
    user.save
    @request.env["devise.mapping"] = Devise.mappings[:user]
    get :show, confirmation_token: user.confirmation_token
    # wrong token
    assert_redirect_to root_path    
    sign_in user # does not work. i.e. user attributes not updated
    assert user_signed_in? # undefined method...?
  end
  
end
