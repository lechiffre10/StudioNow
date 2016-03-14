class AvailabilitiesController < ApplicationController

  before_action :logged_in_user, except: [:index, :get_availabilities]

  def index
    @studio = Studio.find_by(id: params[:studio_id])
    if @studio
      session[:studio_id] = @studio.id
    else
      flash[:notice] = "That studio does not exist"
      redirect_to root_path
    end
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
    @timeslots = @studio.unbooked_times.select{ |av| av[1] >= DateTime.now }
    timeslots = []
    @timeslots.each do |timeslot|
      timeslots << { :color => '#34AADC', :title => 'Open', :start => DateTime.parse(timeslot[0].to_s).iso8601, :end => DateTime.parse(timeslot[1].to_s).iso8601, :allDay => false, :overlap => false}
    end
    render :text => timeslots.to_json
  end

  def get_availabilities
    @studio = Studio.find_by(id: session[:studio_id])
    @availabilities = @studio.availabilities.select{ |av| av.end_time >= DateTime.now-7 }
    availabilities = []
    @availabilities.each do |availability|
      availabilities << {:id => availability.id, :color => '#34AADC', :title => 'Available for Booking', :start => "#{availability.start_time.iso8601}", :description => "You've listed this time slot as available for rent. To remove this slot, click Delete below.", :end => "#{availability.end_time.iso8601}", :allDay => false, :overlap => false}
    end
    @bookings = @studio.bookings.select{ |av| av.end_time >= DateTime.now-7 }
    @bookings.each do |booking|
      availabilities << { :color => 'red', :title => "Booked", :start => "#{booking.start_time.iso8601}", :end => "#{booking.start_time.iso8601}", :description => "This slot is currently booked by #{booking.user.first_name} #{booking.user.last_name}, who booked #{booking.user.bookings.count} studios in the past with an average rating of #{booking.user.average_rating}. You can contact your renter at #{booking.user.email}." , :allDay => false, :overlap => false}
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


