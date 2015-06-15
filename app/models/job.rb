class Job < ActiveRecord::Base
  validates :drop_off_time,            presence: true
  validates :drop_off_location,        presence: true
  validates :pick_up_time,             presence: true
  validates :pick_up_location,         presence: true

  belongs_to :user

  def walk_request(user)
    self.update walk_request_pending_user_id: user.id
  end

  def send_walk_request_mailers(user)
    WalkRequest.walk_request(user, self).deliver_now 
    WalkRequest.walk_request_confirmation(User.find(self.user_id), self).deliver_now
  end

  def approve_walk_request(user)
    self.update walk_request_pending_user_id: nil, walker_id: user.id 
  end

  def send_approve_walk_request_mailers(user)
    WalkRequest.walk_request_approved(user, self).deliver_now
    WalkRequest.walk_request_approved_confirmation(user, self).deliver_now
  end

  def deny_walk_request(user)
    self.update walk_request_pending_user_id: nil
  end

  def send_deny_walk_request_mailers(user)
    WalkRequest.walk_request_denied(user, self).deliver_now
    WalkRequest.walk_request_denied_confirmation(user, self).deliver_now
  end

  def cancel_walk_request
    
  end

  def cancel_confirmed_walk
  end

end
