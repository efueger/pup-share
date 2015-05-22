class Pup < ActiveRecord::Base
  validates :name,            presence: true
  validates :breed,           presence: true  
  validates :weight,          presence: true, numericality: { only_integer: true }
  validates :gender,          presence: true  
  validates :birthday,        presence: true  

  belongs_to :user
  has_and_belongs_to_many :jobs
  
end
