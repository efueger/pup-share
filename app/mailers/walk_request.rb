class WalkRequest < ApplicationMailer
  default :from => 'no-reply@pupshare.com'

  def send_request_email(user, job_id)
    @job_id = job_id
    mail( :to => user.email,
      :subject => 'Can I take your pup for a stroll?' )
  end  
  
  def walk_request_confirmation(user)
    mail( :to => user.email,
      :subject => 'Yay! Your walk request has been approved!' )    
  end
  
  def walk_request_denied(user)
    mail( :to => user.email,
      :subject => 'Sorry. Your walk request has been denied.' )      
  end
  
end
