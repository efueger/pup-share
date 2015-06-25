class ConfirmationsController < Devise::ConfirmationsController
  
  protected
  
  def after_confirmation_path_for(resource_name, resource)
    flash[:notice]
    sign_in(resource_name, resource)
    root_path
  end  
  
end
