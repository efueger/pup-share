class Job < ActiveRecord::Base
  validates :drop_off_time,            presence: true
  validates :drop_off_location,        presence: true
  validates :pick_up_time,             presence: true
  validates :pick_up_location,         presence: true
    
  belongs_to :user
  
  def walk_request
    
  end
  
  def approve_walk_request
    
  end
  
  def deny_walk_request
    
  end
  
  
end
