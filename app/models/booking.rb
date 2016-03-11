class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :availability
  has_one :studio, through: :availability

  validates :start_time, :end_time, presence: true
end
