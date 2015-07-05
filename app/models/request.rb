class Request < ActiveRecord::Base

  belongs_to :user
  belongs_to :requested_of_user, class_name: 'User'
  belongs_to :job

  def walk_request
    WalkRequest.walk_request(self).deliver_now 
    WalkRequest.walk_request_confirmation(self).deliver_now
  end

  def approve_walk_request
    WalkRequest.walk_request_approved(self).deliver_now
    WalkRequest.walk_request_approved_confirmation(self).deliver_now
  end

  def deny_walk_request
    WalkRequest.walk_request_denied(self).deliver_now
    WalkRequest.walk_request_denied_confirmation(self).deliver_now
  end

  def send_mailers
    case self.status
    when 'pending'
      self.walk_request
    when 'approved'
      self.approve_walk_request
    when 'declined'
      self.deny_walk_request
    end
  end
  # can I pass a message to flash for the controller to deliver?



  #   def cancel_walk
  #     self.update walk_request_pending_user_id: nil, walker_id: nil
  #     WalkRequest.walk_request_cancel(self).deliver_now
  #   end

  #   def send_destroyed_walk_mailer
  #     WalkRequest.walk_request_send_destroyed_mailer(self).deliver_now if !self.walker.nil? || !self.walk_request_pending_user.nil? # only send mailer if walker or pending walker is assigned

  #   end

end
