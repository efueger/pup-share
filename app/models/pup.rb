class Pup < ActiveRecord::Base
  validates :pup_name, presence: true
  # validates :pup_vet_phone, presence: true # TODO

  belongs_to :user
  has_many :jobs, dependent: :destroy

  mount_uploader :pup_pic, PupPicUploader

  def hide
    self.update_attributes(hidden: true)
  end
  
end
