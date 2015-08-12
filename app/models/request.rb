class Request < ActiveRecord::Base

  belongs_to :user
  belongs_to :requested_of_user, class_name: 'User'
  belongs_to :job
  belongs_to :availability

  def walk_request
    WalkRequest.walk_request(self).deliver_now 
    self.update_attributes status: 'pending'
  end

  def destroy_enqueued_job
    Delayed::Job.find(self.enqueued_job_id).destroy
  end

  def approve_walk_request
    WalkRequest.walk_request_approved(self).deliver_now 
    self.job.update_attributes actual_walker_id: self.user.id
    # WalkRequest.walk_request_follow_up(self).deliver_later(wait: 1.second)
    # setting enqueued_job_id allows me to locate the enqueued job later for deletion if a request is denied or cancelled
    self.update_attributes status: 'approved'#, enqueued_job_id: Delayed::Job.last.id
    return 'Request approved'
  end

  def deny_walk_request
    WalkRequest.walk_request_denied(self).deliver_now
    self.update_attributes status: 'declined', hidden: true
    # self.destroy_enqueued_job
    return 'Request declined'
  end

  def cancel_walk
    WalkRequest.walk_request_cancel(self).deliver_now 
    self.update_attributes status: 'cancelled', hidden: true
    # self.destroy_enqueued_job
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

end
