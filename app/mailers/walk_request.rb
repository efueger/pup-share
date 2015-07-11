class WalkRequest < ApplicationMailer
  default from: 'no-reply@PupShare.com'
  default cc: 'brntsllvn@gmail.com' # for UX testing. ***REMOVE IN PRODUCTION***

  # cannot extract to before_action because need Request param for each function
  
  def walk_request(request)
    @requested_by = request.user
    @requested_of = request.requested_of_user
    @request      = request # need this in the mailer views
    mail( to: @requested_of.email, 
      subject: 'PupShare: Please approve or deny a walk request' )
  end

  def walk_request_confirmation(request)		
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: @requested_by.email,
      subject: 'PupShare: Confirmation: You submitted a walk request' )    
  end

  def walk_request_approved(request)
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: @requested_by.email,
      subject: 'PupShare: Yay! Your walk request was approved' )
  end

  def walk_request_approved_confirmation(request)
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: @requested_of.email, 
      subject: 'PupShare: Confirmation: You approved a walk request' )  
  end

  def walk_request_denied(request)
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: @requested_by.email, 
      subject: 'PupShare: Sorry. Your walk request was denied' )
  end

  def walk_request_denied_confirmation(request)
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: @requested_of.email, 
      subject: 'PupShare: Confirmation: You declined a walk request' )
  end

  def walk_request_cancel(request)
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: [@requested_by.email, @requested_of.email],
      subject: 'PupShare: Request cancelled notification' )
  end

  def walk_request_send_destroyed_mailer(request)
    @requested_by = request.user	
    @requested_of = request.requested_of_user   		
    @request      = request # need this in the mailer views	
    mail( to: [@requested_by.email, @requested_of.email],
      subject: 'PupShare: Walk removed by owner' )
  end

end
