class Request < ActiveRecord::Base

  belongs_to :user
  belongs_to :requested_of_user, class_name: 'User'
  belongs_to :job
  belongs_to :availability

  def walk_request
    WalkRequest.walk_request(self).deliver_now 
    # user feedback: unnecessary
    # WalkRequest.walk_request_confirmation(self).deliver_now 
  end

  def approve_walk_request
    WalkRequest.walk_request_approved(self).deliver_now
    # user feedback: unnecessary
    # WalkRequest.walk_request_approved_confirmation(self).deliver_now 
  end

  def deny_walk_request
    WalkRequest.walk_request_denied(self).deliver_now
    # user feedback: unnecessary
    # WalkRequest.walk_request_denied_confirmation(self).deliver_now 
  end

  def cancel_walk
    WalkRequest.walk_request_cancel(self).deliver_now
  end

  def destroyed_walk
    WalkRequest.walk_request_send_destroyed_mailer(self).deliver_now
  end

  def send_request_mailers
    case self.status
    when 'pending'
      self.walk_request
      notifier = 'Request submitted'
    when 'approved'
      self.approve_walk_request
      notifier = 'Request approved!'
    when 'declined'
      self.deny_walk_request
      notifier = 'Request declined'
    when 'cancelled'
      self.cancel_walk
      notifier = 'Request cancelled'
    else
      self.destroyed_walk
      return
    end
    return notifier   
  end

end
