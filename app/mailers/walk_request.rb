class WalkRequest < ApplicationMailer
  default :from => 'no-reply@pupshare.com'

  def send_request_email
    mail( :to => 'brntsllvn@gmail.com',
      :subject => 'Can I take your pup for a stroll?' )
  end  
  
  def walk_request_confirmation
    mail( :to => 'brntsllvn@gmail.com',
      :subject => 'Yay! Your walk request has been approved!' )    
  end
  
  def walk_request_denied
    mail( :to => 'brntsllvn@gmail.com',
      :subject => 'Sorry. Your walk request has been denied.' )      
  end
  
end
