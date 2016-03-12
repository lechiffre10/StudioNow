class Availability < ActiveRecord::Base
  has_many :bookings
  belongs_to :studio

  validates :start_time, :end_time, presence: true


  def pretty_print_start_time 
  	self.start_time.strftime('%a, %d %b %Y %H:%M:%S')
  end

 	def pretty_print_end_time 
  	self.end_time.strftime('%a, %d %b %Y %H:%M:%S')
  end
end
