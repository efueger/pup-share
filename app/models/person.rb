class Person < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :jobs,           dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :pups,           dependent: :destroy
  
end
