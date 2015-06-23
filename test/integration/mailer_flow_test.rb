require 'test_helper'
require 'pry'

class MailerFlowTest < ActionDispatch::IntegrationTest

  test 'navigate to root and see my pups' do
    user = FactoryGirl.create(:user)
    #     binding.pry
    https! 
    get '/users/sign_in'
    assert_response :success
        
  end
  
  
end
