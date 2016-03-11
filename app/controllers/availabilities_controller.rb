class AvailabilitiesController < ApplicationController
  def index
    @studio = Studio.find_by(id: params[:studio_id])
  end

  def new
    @studio = Studio.find_by(id: params[:studio_id])
    @availability = Availability.new(:end_time => 1.hour.from_now)
    render :json => {:form => render_to_string(:partial => 'form')}
  end


  def get_availabilities
    @availabilities = Availability.all
    availabilities = []
    @availabilities.each do |availability|
      availabilities << {:id => availability.id, :title => 'available', :description => "Some cool description here...", :start => "#{availability.start_time.iso8601}", :end => "#{availability.end_time.iso8601}", :allDay => false}
    end
    render :text => availabilities.to_json
  end
end


# add this to the end of each availability to add recurring or all day functionality
#, :allDay => availability.all_day, :recurring => (availability.event_series_id)? true: false

# this was at the end of the availability.find instead of availability.all method and it wasn't returning any results. Not sure why yet.
# find(:all, :conditions => ["start_time >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and end_time <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
