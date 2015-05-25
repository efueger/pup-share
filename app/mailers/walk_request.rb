class WalkRequest < ApplicationMailer
  default :from => 'no-reply@pupshare.com'

  def send_request_email
    mail( :to => 'brntsllvn@gmail.com',
      :subject => 'Can I take your pup for a stroll?' )
  end  
end
