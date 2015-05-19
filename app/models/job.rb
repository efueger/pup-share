class Job < ActiveRecord::Base
  belongs_to :person
  has_many :pups
end
