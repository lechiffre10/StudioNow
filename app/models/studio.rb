class Studio < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :availabilities
  has_many :reviews, as: :reviewable
  has_many :ratings, as: :ratable
  has_many :bookings, through: :availabilities
  has_many :images

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  validates :name, :full_address, :price, :description, presence: true

  def self.search(searched_location)
    Studio.near(searched_location, 30)
  end

  def future_availabilities
    self.availabilities.reject { |availability| availability.start_time.past? }
  end

  def sorted_availabilities
    future_availabilities.sort_by { |availability| availability.start_time }    
  end  

  def average_rating
    total = self.ratings.length
    total != 0 ? self.ratings.inject(0) { |sum, rating| sum += rating.value }/self.ratings.count : 0
  end

end
