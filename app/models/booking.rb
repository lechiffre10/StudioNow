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

  # This method takes in a date and time string and returns a datetime object:
  def self.time_to_datetime(time)
    DateTime.strptime(time, '%m/%d/%Y %I:%M%p')
  end

  def self.total_price(start_time, end_time, price)
    hours = ((end_time - start_time) * 24).to_i
    total_price = price * hours
  end

end
