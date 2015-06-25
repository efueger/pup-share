class Pup < ActiveRecord::Base
  
  belongs_to :user
  has_many :jobs
  
  mount_uploader :pup_pic, PupPicUploader

end
