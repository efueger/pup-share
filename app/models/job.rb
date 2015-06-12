class Job < ActiveRecord::Base
  validates :drop_off_time,            presence: true
  validates :drop_off_location,        presence: true
  validates :pick_up_time,             presence: true
  validates :pick_up_location,         presence: true

  belongs_to :user

  def walk_request(user)
    self.update walk_request_pending: true, 
                walk_request_pending_user_id: user.id
    WalkRequest.send_request_email(user, self).deliver_now 
  end

  def approve_walk_request(user)
    self.update walk_request_pending: false, 
                walk_request_pending_user_id: nil, 
                walk_request_confirmed: true, 
                walker_id: user.id 
    WalkRequest.walk_request_confirmation(user).deliver_now
  end
  
  def deny_walk_request(user)
    self.update walk_request_pending: false, 
                walk_request_pending_user_id: nil,
                walk_request_confirmed: false, 
                walker_id: nil
    WalkRequest.walk_request_denied(user).deliver_now
  end
  
end
