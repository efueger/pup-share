class Request < ActiveRecord::Base

  belongs_to :user
  belongs_to :requested_of_user, class_name: 'User'
  belongs_to :job

  def walk_request(requester)
    self.update status: 'pending'
    WalkRequest.walk_request(self).deliver_now 
    # WalkRequest.walk_request_confirmation(self).deliver_now
  end

end
