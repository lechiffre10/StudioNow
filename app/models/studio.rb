class Studio < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :availabilities
  has_many :reviews, as: :reviewable
  has_many :rates_without_dimension, -> { where dimension: nil}, as: :rateable, class_name: 'Rate', dependent: :destroy
  has_many :bookings, through: :availabilities
  has_many :images
  ratyrate_rateable

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
    total = self.rates.length
    total != 0 ? self.rates.inject(0) { |sum, rating| sum += rating.stars.to_i }/self.rates.count : 0
  end

  def unbooked_times
    all_unbooked_times = availabilities.map do |availability|
      availability.unbooked_times.map{ |array_of_times| array_of_times << availability.id}
    end
    all_unbooked_times.flatten(1)
  end

end
