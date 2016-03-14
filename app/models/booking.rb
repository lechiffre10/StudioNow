class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :availability
  has_one :studio, through: :availability
  validate :valid_booking
  validates :start_time, :end_time, presence: true

  def self.find_timeslot(start_time,end_time,studio)
    current_timeslots = studio.unbooked_times
    slots_valid_start = current_timeslots.select{|timeslot| DateTime.parse(timeslot[0].to_s) <= start_time}
    slots_valid_end = slots_valid_start.select{|timeslot| DateTime.parse(timeslot[1].to_s) >= end_time}.flatten(1)
    if slots_valid_end.empty?
      return nil
    else
      return Availability.find_by(id: slots_valid_end)
    end
  end

  def pretty_print_start_time
  	self.start_time.strftime('%a, %d %b %Y %H:%M:%S')
  end

  def pretty_print_end_time
  	self.end_time.strftime('%a, %d %b %Y %H:%M:%S')
  end

  # This method takes in a date and time string and returns a datetime object:
  def self.convert_to_datetime(time)
    DateTime.strptime(time, '%m/%d/%Y %I:%M%p')
  end

  def self.total_price(start_time, end_time, price)
    hours = ((end_time - start_time) * 24).to_i
    total_price = price * hours
  end

  def valid_booking
    if self.start_time && self.end_time && self.start_time >= self.end_time
      errors.add(:base,"Your booking start date cannot be after the end date")
      puts errors.full_messages
    end
  end

end
