class ConfirmationsController < Devise::ConfirmationsController


  private

  def after_confirmation_path_for(resource_name, resource)
    flash[:notice]
    sign_in(resource_name, resource)
    jobs_path
  end  

end
