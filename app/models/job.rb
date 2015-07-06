class Job < ActiveRecord::Base
  validates :drop_off_time,            presence: true
  validates :drop_off_location,        presence: true
  validates :pick_up_time,             presence: true
  validates :pick_up_location,         presence: true
  validates :pup_id,                   presence: true
  validates :user_id,                  presence: true
  
  belongs_to :user
  belongs_to :pup
  has_many   :requests, dependent: :destroy

end

