class Job < ActiveRecord::Base
  validates :drop_off_time,            presence: true
  validates :drop_off_location,        presence: true
  validates :pick_up_time,             presence: true
  validates :pick_up_location,         presence: true
    
  belongs_to :person
  has_and_belongs_to_many :pups # no dependent destroy here because if a job is destoyed it should not take all pups with it!
end
