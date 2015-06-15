class WalkRequest < ApplicationMailer
  default from: 'no-reply@pup-share.com'

  # before_action here to set @walker,@pup_owner, @job would be cool
  
  def walk_request(job)
    @walker    = User.find(job.walk_request_pending_user_id)
    @pup_owner = job.user    
    @job       = job
    mail( to: @pup_owner.email, 
      from: @walker.email,
      subject: 'Please approve or deny a walk request' )
  end  

  def walk_request_confirmation(job)
    @walker    = User.find(job.walk_request_pending_user_id)
    @pup_owner = job.user    
    @job       = job
    mail( to: @walker.email,
      subject: 'Confirmation: You submitted a walk request' )    
  end

  def walk_request_approved(job)
    @walker    = User.find(job.walk_request_pending_user_id)
    @pup_owner = job.user
    @job       = job
    mail( to: @walker.email,
      from: @pup_owner.email,
      subject: 'Yay! Your walk request was approved' )
  end

  def walk_request_approved_confirmation(job)
    @walker    = User.find(job.walk_request_pending_user_id)
    @pup_owner = job.user
    @job       = job
    mail( to: @pup_owner.email, 
      subject: 'Confirmation: You approved a walk request' )  
  end

  def walk_request_denied(job)
    @walker    = User.find(job.walk_request_pending_user_id)
    @pup_owner = job.user
    @job       = job
    mail( to: @walker.email, 
      from: @pup_owner.email,
      subject: 'Sorry. Your walk request was denied' )
  end

  def walk_request_denied_confirmation(job)
    @walker    = User.find(job.walk_request_pending_user_id)
    @pup_owner = job.user
    @job       = job
    mail( to: @pup_owner.email, 
      subject: 'Confirmation: You declined a walk request' )
  end

  def walk_request_cancel(job)
    @walker    = User.find(job.walk_request_pending_user_id)
    @pup_owner = job.user
    @job       = job
    mail( to: [@pup_owner.email, @walker.email],
      subject: 'Walk cancelled notification' )
  end
  
end
