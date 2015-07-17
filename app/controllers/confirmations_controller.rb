class ConfirmationsController < Devise::ConfirmationsController
  
  
  
  
  
  
  
  
  private
  
  def after_confirmation_path_for(resource_name, resource)
    # activate after token is working
    flash[:notice]
    sign_in(resource_name, resource)
    root_path
  end  
  
end
