class Pup < ActiveRecord::Base
  
  belongs_to :user
  has_many :jobs, dependent: :destroy
  
  mount_uploader :pup_pic, PupPicUploader

end
