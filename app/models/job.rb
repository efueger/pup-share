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
    self.update_attributes how_did_it_go: feedback, hidden: true
    User.find(self.actual_walker_id).increment!(:walks_completed, by = 1)
    self.pup.increment!(:walks_completed, by = 1)

    case feedback
    when 'awesome'
      User.find(self.actual_walker_id).increment!(:awesome_count, by = 1)
    when 'not_good'
      User.find(self.actual_walker_id).increment!(:not_good_count, by = 1)
    when 'no_show'
      User.find(self.actual_walker_id).increment!(:no_show_count, by = 1)
    end

    return 'Feedback recorded'
  end # update_follow_up_attr

end

