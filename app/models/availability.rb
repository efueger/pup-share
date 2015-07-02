class Availability < ActiveRecord::Base
  validates :available_from,   presence: true
  validates :available_to,     presence: true
  validates :location,         presence: true
  validates :comment,          presence: true

  belongs_to :user

end
