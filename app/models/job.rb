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

  def hide
    self.update_attributes(hidden: true)
  end

  def already_requested_and_declined?(user)
    # returns true if the user's request has already been declined
    # returns false if the user's request has not been declined
    return false if self.requests.where(user_id: user.id).first.nil?
    return self.requests.where(user_id: user.id).first.hidden
  end

end

