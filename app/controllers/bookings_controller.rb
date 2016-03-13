class BookingsController < ApplicationController

  def new

  end

  def create
    p "%%%%%%%%%%%%%%%%%%%%%%%%"
    start_date = params[:start_date]
    s_time = params[:s_time]
    end_date = params[:end_date]
    e_time = params[:e_time]
    start = "#{start_date} #{s_time}"
    e = "#{end_date} #{e_time}"

    start_time = DateTime.strptime(start, '%m/%d/%Y %I:%M%p')
    end_time = DateTime.strptime(e, '%m/%d/%Y %I:%M%p')

    @studio = Studio.find_by(id: params[:studio_id])
    @availability = Availability.find_by(id: 10)

    p "This is the availability object!!!!"
    p @availability

    @booking = @availability.bookings.new(start_time: start_time, end_time: end_time, user_id: session[:user_id])

    p "This is the booking object!!!!"
    p @booking

    if @booking.save
      p "You are inside the 'save' if statement!!!!!"
      redirect_to studio_path(@studio), notice: "Your booking has been submitted."
    else
      @errors = @booking.errors.full_messages
      render 'studio/show'
    end
  end

  def destroy

  end


  private
  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :availability_id, :user_id)
  end


end





# <%= form_for([@studio, Availability.new, @booking], :url => studio_availability_bookings_path(@studio.id, 10), :html => { :id => "basicExample" }) do |f| %>
#   <%= f.text_field :start_date, :class => "date start" %>
#   <%= f.text_field :s_time, :class => "time start" %>
#   <%= f.text_field :end_date, :class => "date end" %>
#   <%= f.text_field :e_time, :class => "time end" %>
#   <%= f.submit "Request Studio Time" %>
# <% end %>
