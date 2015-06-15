class WalkRequest < ApplicationMailer
  default from: 'no-reply@pup-share.com'

  def walk_request(walker, job)
    @walker    = walker
    @pup_owner = job.user    
    @job       = job
    # NOTE: the test does not know the association between job and user
    # so job.user == nil
    mail( to: @pup_owner.email, 
      from: @walker.email,
      subject: "Please approve or deny a walk request" )
  end  

  def walk_request_confirmation(walker, job)
    @walker    = walker
    @pup_owner = job.user    
    @job       = job
    mail( to: @walker.email,
      subject: "Confirmation: You submitted a walk request" )    
  end

  def walk_request_approved(pup_owner, job)
    @walker    = User.find(job.walker_id)
    @pup_owner = pup_owner
    @job       = job
    mail( to: @walker.email,
      from: @pup_owner.email,
      subject: "Yay! Your walk request was approved" )
  end

  def walk_request_approved_confirmation(pup_owner, job)
    @walker    = User.find(job.walker_id)
    @pup_owner = pup_owner
    @job       = job
    mail( to: @pup_owner.email, 
      subject: "Confirmation: You approved a walk request" )  
  end

  def walk_request_denied(pup_owner, job)
    @walker    = User.find(job.walk_request_pending_user_id)
    @pup_owner = pup_owner
    @job       = job
    mail( to: @walker.email, 
      from: @pup_owner.email,
      subject: "Sorry. Your walk request was denied" )
  end

  def walk_request_denied_confirmation(pup_owner, job)
    @walker    = User.find(job.walk_request_pending_user_id)
    @pup_owner = pup_owner
    @job       = job
    mail( to: @pup_owner.email, 
      subject: "Confirmation: You declined a walk request" )
  end

end
