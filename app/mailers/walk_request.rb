class WalkRequest < ApplicationMailer
  default from: 'no-reply@pup-share.com'

  def walk_request(walk_requester, job)
    @walk_requester = walk_requester
    @pup_owner      = job.user    
    @job            = job
    mail( to: @pup_owner.email, 
      subject: "Please approve or decline #{@walk_requester.email}'s request to walk #{@job.pup_name}" )
  end  

  def walk_request_confirmation(walk_requester, job)
    @walk_requester = walk_requester
    @pup_owner      = job.user    
    @job            = job
    mail( to: @walk_requester.email, 
      subject: "Confirmation: You requested to walk #{@pup_owner.email}'s pup #{@job.pup_name}" )    
  end

  def walk_request_approved(pup_owner, job)
    @walker    = User.find(job.walker_id)
    @pup_owner = pup_owner
    @job       = job
    mail( to: @walker.email, 
      subject: "Yay! Your request to walk #{@pup_owner.email}'s pup #{@job.pup_name} was approved!" )
  end

  def walk_request_approved_confirmation(pup_owner, job)
    @walker    = User.find(job.walker_id)
    @pup_owner = pup_owner
    @job       = job
    mail( to: @pup_owner.email, 
      subject: "Confirmation: You approved #{@walker.email}'s request to walk your pup #{@job.pup_name}" )  
  end

  def walk_request_denied(pup_owner, job)
    @walk_requester = User.find(job.walk_request_pending_user_id)
    @pup_owner      = pup_owner
    @job            = job
    mail( to: @walk_requester.email, 
      subject: "Sorry. Your request to walk #{@pup_owner.email}'s pup #{@job.pup_name} was denied." )
  end

  def walk_request_denied_confirmation(pup_owner, job)
    @walk_requester = User.find(job.walk_request_pending_user_id)
    @pup_owner      = pup_owner
    @job            = job
    mail( to: @pup_owner.email, 
      subject: "Confirmation: You declined #{@walk_requester.email}'s request to walk #{@job.pup_name}" )
  end

end
