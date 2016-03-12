class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :availability
  has_one :studio, through: :availability

  validates :start_time, :end_time, presence: true


  def pretty_print_start_time 
  	self.start_time.strftime('%a, %d %b %Y %H:%M:%S')
  end

 	def pretty_print_end_time 
  	self.end_time.strftime('%a, %d %b %Y %H:%M:%S')
  end

end
