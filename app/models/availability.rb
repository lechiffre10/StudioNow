class Availability < ActiveRecord::Base
  has_many :bookings
  belongs_to :studio

  validates :start_time, :end_time, presence: true
  # validate :valid_availability

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
    until i == (array.length) do
      final_array << [array[i], array[i+1]]
      i += 2
    end
    final_array
  end

  def valid_availability
    valid_start && valid_end ? return : errors.add(:start_time, "You cannot have an overlap of availabilities")
  end

  def valid_start
    studio = Studio.find_by(id: self.studio_id)
    unavailable_times = studio.availabilities.select do |av|
      existing_start = av.start_time
      existing_end = av.end_time
      self.start_time.between?(existing_start, existing_end) == true
    end
    empty_array?(unavailable_times)
  end

  def valid_end
    studio = Studio.find_by(id: self.studio_id)
    unavailable_times = studio.availabilities.select do |av|
      existing_start = av.start_time
      existing_end = av.end_time
      self.start_time.between?(existing_start, existing_end) == true
    end
    empty_array?(unavailable_times)
  end

  def empty_array?(array)
    if array.length > 0
      return false
    else
      return true
    end
  end



end
