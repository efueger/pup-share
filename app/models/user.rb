class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :confirmable,
  :recoverable, :rememberable, :trackable, :validatable

  # validates :first_name,            presence: true, length: { minimum: 2, maximum: 50 }
  # validates :last_name,             presence: true, length: { minimum: 2, maximum: 50 }
  # validates :building,              presence: true
  # validates :address,               presence: true, length: { minimum: 2, maximum: 100 }  
  # validates :phone,                 presence: true 
  # consider using the 'format' validation later
  # validates :emergency_phone,       presence: true 
  # consider using the 'format' validation later
  # validates :pic,                   presence: true

  validates_format_of :email, :with => /.{1,50}@amazon.com/, message: "Email address must have @amazon domain", on: :create  

  has_many :jobs, dependent: :destroy
  has_many :pups, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :requests, dependent: :destroy

  mount_uploader :pic, UserPicUploader

  def walker_jobs
    walker_jobs = []
    self.requests.each do |request|
      walker_jobs << request.job      
    end
    return walker_jobs
  end

  def all_my_jobs
    empty_arr = []
    all_my_jobs = self.jobs + self.walker_jobs
    return all_my_jobs unless all_my_jobs.nil?
    return empty_arr
  end

end
