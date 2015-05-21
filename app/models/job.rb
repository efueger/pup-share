class Job < ActiveRecord::Base
  belongs_to :person
  has_many :pups # no dependent destroy here because if a job is destoyed it should not take all pups with it!
end
