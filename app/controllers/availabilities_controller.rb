class AvailabilitiesController < ApplicationController
  def index
    @studio = Studio.find_by(id: params[:studio_id])
    session[:studio_id] = @studio.id
  end

  def new
    @studio = Studio.find_by(id: params[:studio_id])
    @availability = Availability.new(:end_time => 1.hour.from_now)
    render :json => {:form => render_to_string(:partial => 'form')}
  end

  def create
    @studio = Studio.find_by(id: params[:studio_id])
    availability = @studio.availabilities.create(availability_params)
    if availability.save
      render :nothing => true
    else
      render :text => availability.errors.full_messages.to_sentence, :status => 422
    end
  end
def get_available_timeslots
    @studio = Studio.find_by(id: session[:studio_id])
    @timeslots = @studio.unbooked_times
    timeslots = []
    @timeslots.each do |timeslot|
      timeslots << { :color => '#34AADC', :title => 'Open', :start => DateTime.parse(timeslot[0].to_s).iso8601, :end => DateTime.parse(timeslot[1].to_s).iso8601, :allDay => false, :overlap => false}
    end
    render :text => timeslots.to_json
  end

  def get_availabilities
    @studio = Studio.find_by(id: session[:studio_id])
    @availabilities = @studio.availabilities
    availabilities = []
    @availabilities.each do |availability|
      availabilities << {:id => availability.id, :color => '#34AADC', :title => 'Available for Booking', :start => "#{availability.start_time.iso8601}", :end => "#{availability.end_time.iso8601}", :allDay => false, :overlap => false}
    end
    @bookings = @studio.bookings
    @bookings.each do |booking|
      availabilities << { :color => 'red', :title => 'Booked', :start => "#{booking.start_time.iso8601}", :end => "#{booking.start_time.iso8601}", :allDay => false, :overlap => false}
    end
    render :text => availabilities.to_json
  end

  def move
    @availability = Availability.find_by_id(params[:id])
    if @availability
      @availability.start_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@availability.start_time))
      @availability.end_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@availability.end_time))
      @availability.save
    end
    render :nothing => true
  end

  def resize
    @availability = Availability.find_by_id(params[:id])
    if @availability
      @availability.end_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@availability.end_time))
      @availability.save
    end
    render :nothing => true
  end

  def destroy
    @studio = Studio.find_by(id: params[:studio_id])
    @availability = Availability.find_by(id: params[:id])
    @availability.destroy
    render :nothing => true
  end

  private
  def availability_params
    params.require(:availability).permit(:start_time, :end_time)
  end

end


