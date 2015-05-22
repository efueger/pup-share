class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name,            presence: true, length: { minimum: 2, maximum: 50 }
  validates :last_name,             presence: true, length: { minimum: 2, maximum: 50 }
  validates :building,              presence: true
  validates :address,               presence: true, length: { minimum: 2, maximum: 100 }  
  validates :phone,                 presence: true # consider using the 'format' validation later
  validates :emergency_phone,       presence: true # consider using the 'format' validation later
  
  has_many :jobs, dependent: :destroy
  has_many :pups, dependent: :destroy
end
