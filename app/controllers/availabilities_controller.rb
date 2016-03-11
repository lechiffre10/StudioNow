class AvailabilitiesController < ApplicationController
  def index
    @studio = Studio.find_by(id: params[:studio_id])
  end

  def new
    @studio = Studio.find_by(id: params[:studio_id])
    @availability = Availability.new(:end_time => 1.hour.from_now)
    render :json => {:form => render_to_string(:partial => 'form')}
  end

  def create
    availability = Availability.new(availability_params)
    if availability.save
      render :nothing => true
    else
      render :text => availability.errors.full_messages.to_sentence, :status => 422
    end
  end


  def get_availabilities
    @availabilities = Availability.all
    availabilities = []
    @availabilities.each do |availability|
      availabilities << {:id => availability.id, :title => 'available', :description => "Some cool description here...", :start => "#{availability.start_time.iso8601}", :end => "#{availability.end_time.iso8601}", :allDay => false}
    end
    render :text => availabilities.to_json
  end

  def move
    @availability = Availability.find_by_id(params[:id])
    if @availability
      @availability.start_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.starttime))
      @availability.end_time = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.endtime))
      @event.save
    end
    render :nothing => true
  end

  private
  def availability_params
    params.require(:event).permit('title', 'description', 'starttime(1i)', 'starttime(2i)', 'starttime(3i)', 'starttime(4i)', 'starttime(5i)', 'endtime(1i)', 'endtime(2i)', 'endtime(3i)', 'endtime(4i)', 'endtime(5i)', 'all_day', 'period', 'frequency', 'commit_button')
    end
  end
end


# add this to the end of each availability to add recurring or all day functionality
#, :allDay => availability.all_day, :recurring => (availability.event_series_id)? true: false

# this was at the end of the availability.find instead of availability.all method and it wasn't returning any results. Not sure why yet.
# find(:all, :conditions => ["start_time >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and end_time <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
