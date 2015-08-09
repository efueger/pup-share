class Job < ActiveRecord::Base
  validates :drop_off_time,            presence: true
  validates :drop_off_location,        presence: true
  validates :walk_duration,            presence: true
  validates :pick_up_location,         presence: true
  validates :pup_id,                   presence: true
  validates :user_id,                  presence: true

  belongs_to :user
  belongs_to :pup
  has_many   :requests, dependent: :destroy

  def hide
    self.update_attributes hidden: true
  end

  def update_follow_up_attr(feedback)
    # prevent user from submitting feedback multiple times on same job
    return 'Feedback previously recorded for this walk' if self.hidden

    self.update_attributes how_did_it_go: feedback, hidden: true

    walker = User.find(self.actual_walker_id)
    walker.increment!(:walks_completed, by = 1)
    self.pup.increment!(:walks_completed, by = 1)

    ### ***
    ### ***
    ### ***
    ### ***
    ### ***
    ### ***
    ### ***
    ### ***
    ### ***
    case feedback
    when 'stars_5'
      walker.update_attributes feedback_rating: walker.feedback_rating + 5.0 / walker.walks_completed
    when 'stars_4'
      walker.update_attributes feedback_rating: walker.feedback_rating + 4.0 / walker.walks_completed
    when 'stars_3'
      walker.update_attributes feedback_rating: walker.feedback_rating + 3.0 / walker.walks_completed
    when 'stars_2'
      walker.update_attributes feedback_rating: walker.feedback_rating + 2.0 / walker.walks_completed
    when 'stars_1'
      walker.update_attributes feedback_rating: walker.feedback_rating + 1.0 / walker.walks_completed
    end
    return 'Feedback recorded. Thanks!'
  end # update_follow_up_attr

  ### ***
  ### ***
  ### ***
  ### ***
  ### ***
  ### ***
  ### ***
  ### ***
  ### ***

end

