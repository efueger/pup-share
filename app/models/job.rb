class Job < ActiveRecord::Base
  validates :drop_off_time,            presence: true
  validates :drop_off_location,        presence: true
  validates :pick_up_time,             presence: true
  validates :pick_up_location,         presence: true

  belongs_to :user

  def walk_request(user)
    self.update walk_request_pending_user_id: user.id
    WalkRequest.send_request_email(user, self).deliver_now 
    WalkRequest.send_walker_request_confirmation(User.find(self.user_id), self).deliver_now
  end
  
#   def cancel_walk_request
#     self.update walk_request_pending_user_id: nil, walker_id: nil
#     WalkRequest.cancel_walk_request(self).deliver_now
#   end

#   def cancel_confirmed_walk
#     self.update walk_request_pending_user_id: nil, walker_id: nil
#     WalkRequest.cancel_confirmed_walk(self).deliver_now
#   end
  
  def approve_walk_request(user)
    self.update walk_request_pending_user_id: nil, walker_id: user.id 
    WalkRequest.walk_request_confirmation(user, self).deliver_now
  end
  
  def deny_walk_request(user)
    self.update walk_request_pending_user_id: nil, walker_id: nil
    WalkRequest.walk_request_denied(user, self).deliver_now
  end
  
end
