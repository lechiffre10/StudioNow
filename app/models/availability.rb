class Availability < ActiveRecord::Base
  has_many :bookings
  belongs_to :studio

  validates :start_time, :end_time, presence: true

end
