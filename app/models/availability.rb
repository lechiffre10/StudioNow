class Availability < ActiveRecord::Base
  has_many :bookings
  belongs_to :studio

  validates :start_time, :end_time, presence: true

  def unbooked_times
    all_times = [self.start_time]
    all_bookings = self.bookings.sort_by {|booking| booking.start_time }
    until all_bookings.length == 0 do 
    	all_times << all_bookings.first.start_time
    	all_times << all_bookings.first.end_time
    	all_bookings.shift
    end
    all_times << self.end_time
    create_multi_level_array(all_times)
  end

  def create_multi_level_array(array)
  	final_array = []
  	i = 0
  	until i == (array.length - 1) do 
  		final_array << [beautify(array[i]), beautify(array[i+1])]
  		i += 1
  	end
  	final_array
  end


  def beautify(time) 
  	time.strftime('%a, %d %b %Y %H:%M:%S')
  end

end
