class WalkRequest < ApplicationMailer
  default :from => 'no-reply@pupshare.com'

  def send_request_email(user, job)
    @user = user
    @job  = job
    mail( to: @job.user.email, subject: "Please approve or decline #{@user.email}'s request to walk #{@job.pup_name}" )
  end  

  # TO DO: add corresponding view that has walk details
  def send_request_walker_email(user, job)
    @user = user
    @job  = job
    mail( to: user.email, 
      subject: "You requested to walk #{@job.pup_name} at #{@job.drop_off_time.to_formatted_s(:long_ordinal)}" )    
  end

  def walk_request_confirmation(user)
    mail( to: user.email, subject: 'Yay! Your walk request has been approved!' )
  end

  def walk_request_denied(user)
    mail( to: user.email, subject: 'Sorry. Your walk request has been denied.' )
  end

end
