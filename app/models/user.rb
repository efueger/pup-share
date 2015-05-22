class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name,            presence: true
  validates :last_name,             presence: true
  validates :building,              presence: true
  validates :address,               presence: true  
  validates :phone,                 presence: true
  validates :emergency_phone,       presence: true  
  
  has_many :jobs, dependent: :destroy
  has_many :pups, dependent: :destroy
end
