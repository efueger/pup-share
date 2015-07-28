class Request < ActiveRecord::Base

  belongs_to :user
  belongs_to :requested_of_user, class_name: 'User'
  belongs_to :job
  belongs_to :availability

  def walk_request
    WalkRequest.walk_request(self).deliver_now 
    self.update_attributes status: 'pending'
  end

  def approve_walk_request
    WalkRequest.walk_request_approved(self).deliver_now 
    self.update_attributes status: 'approved'
    return 'Request approved'
  end

  def deny_walk_request
    WalkRequest.walk_request_denied(self).deliver_now
    self.update_attributes status: 'declined', hidden: true
    return 'Request declined'
  end

  def cancel_walk
    WalkRequest.walk_request_cancel(self).deliver_now 
    self.update_attributes status: 'cancelled', hidden: true
    return 'Walk cancelled'
  end

  def send_request_mailers(status)
    case status
    when 'approved'
      self.approve_walk_request
    when 'declined'
      self.deny_walk_request
    when 'cancelled'
      self.cancel_walk
    end
  end
  
  def already_requested_and_declined?(job, user)
    request = Request.where(job_id: job.id, user_id: user.id)
    return request.hidden
  end

end

