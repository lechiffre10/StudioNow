class Studio < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :availabilities
  has_many :reviews, as: :reviewable
  has_many :ratings, as: :ratable
  has_many :bookings, through: :availabilities

  validates :name, :address, :city, :state, :zip_code, :price, :description, presence: true

  def self.search(searched_location)
    #need to take in the inputs from the search box and get the coordinates of them from google api, then find the studios within a certain range based on their coordinates, then return a collection of those studios
  end
end
