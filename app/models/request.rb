class Request < ActiveRecord::Base

  belongs_to :user
  belongs_to :requested_of_user, class_name: 'User'
  belongs_to :job
  belongs_to :availability
  
  def walk_request
    WalkRequest.walk_request(self).deliver_now 
  end

  def approve_walk_request
    WalkRequest.walk_request_approved(self).deliver_now 
  end

  def deny_walk_request
    WalkRequest.walk_request_denied(self).deliver_now
  end

  def cancel_walk
    WalkRequest.walk_request_cancel(self).deliver_now 
  end

end
