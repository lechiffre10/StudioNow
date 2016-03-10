class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :availability
  belongs_to :studio, through: :availability

  validates :start_time, :end_time, presence: true
end
