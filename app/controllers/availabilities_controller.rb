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


  def get_availabilities
    # hi it's ray. we need to somehow filter based on studio id to only get the availabilities for this studio. Right now we call the get_availabilities method from our availabilities_calendar.js file, but don't pass the studio id at any point. I don't have an answer to this but wanted to call it out while I was thinking about it.
    # puts params
    # @studio = Studio.find_by_id(params[:studio_id])
    @studio = Studio.find_by(id: session[:studio_id])
    @availabilities = @studio.availabilities
    availabilities = []
    @availabilities.each do |availability|
      availabilities << {:id => availability.id, :title => 'Available for Booking', :start => "#{availability.start_time.iso8601}", :end => "#{availability.end_time.iso8601}", :allDay => false, :overlap => false}
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


  # def availability_params
  #   params.require(:availability).permit('title', 'description', 'starttime(1i)', 'starttime(2i)', 'starttime(3i)', 'starttime(4i)', 'starttime(5i)', 'endtime(1i)', 'endtime(2i)', 'endtime(3i)', 'endtime(4i)', 'endtime(5i)', 'all_day', 'period', 'frequency', 'commit_button')
  # end
end


# add this to the end of each availability to add recurring or all day functionality
#, :allDay => availability.all_day, :recurring => (availability.event_series_id)? true: false

# this was at the end of the availability.find instead of availability.all method and it wasn't returning any results. Not sure why yet.
# find(:all, :conditions => ["start_time >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and end_time <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
