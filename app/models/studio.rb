class Studio < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :availabilities
  has_many :reviews, as: :reviewable
  has_many :ratings, as: :ratable
  has_many :bookings, through: :availabilities

  validates :name, :address, :city, :state, :zip_code, :price, :description, presence: true
end
