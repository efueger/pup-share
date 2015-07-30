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

  def update_follow_up_attr(feedback)
    self.how_did_it_go = feedback, 
    self.hide
    self.actual_walker.walks_completed += 1
    self.pup.walks_completed += 1
    case feedback
    when 'awesome'
      self.actual_walker.awesome_count += 1
    when 'not_good'
      self.actual_walker.not_good_count += 1
    when 'no_show'
      self.actual_walker.no_show_count += 1
    end
    return 'Feedback recorded'
  end

end

