class Job < ActiveRecord::Base
  validates :drop_off_time,            presence: true
  validates :drop_off_location,        presence: true
  validates :pick_up_time,             presence: true
  validates :pick_up_location,         presence: true

  belongs_to :user

  def walk_request(user, job_id)
    # if current_user.user_pending_requests_count == 0
    self.update walk_request_pending: true, walk_request_pending_user_id: user.id
    WalkRequest.send_request_email(user, job_id).deliver_now
    #   user.increment_walk_request_count
    # else
    #   redirect_to root_path, alert: 'Max outstanding requests is 1.'  
    # end    
  end

  def approve_walk_request
    # how does Rails know which @job the email is referring to?  
  end
  
  def deny_walk_request
    # how does Rails know which @job the email is referring to?      
  end
  
  
end
