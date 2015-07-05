class WalkRequest < ApplicationMailer
  default from: 'no-reply@pup-share.com'

  def walk_request(request)
    @requested_by = request.user
    @requested_of = request.requested_of_user
    @request      = request # need this in the mailer views
    mail( to: @requested_of.email, 
      subject: 'Please approve or deny a walk request' )
  end

  def walk_request_confirmation(request)		
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: @requested_by.email,
      subject: 'Confirmation: You submitted a walk request' )    
  end

  def walk_request_approved(request)
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: @requested_by.email,
      subject: 'Yay! Your walk request was approved' )
  end

  def walk_request_approved_confirmation(request)
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: @requested_of.email, 
      subject: 'Confirmation: You approved a walk request' )  
  end

  def walk_request_denied(request)
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: @requested_by.email, 
      subject: 'Sorry. Your walk request was denied' )
  end

  def walk_request_denied_confirmation(request)
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: @requested_of.email, 
      subject: 'Confirmation: You declined a walk request' )
  end

  def walk_request_cancel(request)
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: [@requested_by.email, @requested_of.email],
      subject: 'Walk cancelled notification' )
  end

#   def walk_request_send_destroyed_mailer(job)
#     @walker    = job.walker.nil? ? job.walk_request_pending_user : job.walker 
#     @pup_owner = job.user
#     @job       = job 
#     mail( to: [@pup_owner.email, @walker.email],
#       subject: 'Walk removed by owner' )
#   end

end
