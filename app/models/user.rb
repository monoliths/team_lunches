class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :city
  geocoded_by :city
  validates :email, length: {minimum: 6, maximum: 60}

  after_validation :geocode, :if => :city_changed?
end
