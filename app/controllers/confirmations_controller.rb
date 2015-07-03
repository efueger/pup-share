class ConfirmationsController < Devise::ConfirmationsController
  
  def show
    # binding.pry
    super
  end
  
  private
  
  def after_confirmation_path_for(resource_name, resource)
    # activate after token is working
    # binding.pry
    flash[:notice]
    sign_in(resource_name, resource)
    root_path
  end  
  
end
