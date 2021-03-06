class Availability < ActiveRecord::Base
  validates :available_from,   presence: true
  validates :available_to,     presence: true
  validates :location,         presence: true

  belongs_to :user
  belongs_to :pup
  has_many   :requests, dependent: :destroy
end
