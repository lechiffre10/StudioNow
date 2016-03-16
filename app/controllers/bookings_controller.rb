class BookingsController < ApplicationController

  before_action :logged_in_booking, only: [:create, :destroy]

  def logged_in_booking
    unless logged_in?
      @studio = Studio.find_by(id: params[:studio_id])
      flash[:danger] = "Please log in."
      redirect_to studio_path(@studio)
    end
  end

  def create
    @studio = Studio.find_by(id: params[:studio_id])

    concat_start = "#{params[:start_date]} #{params[:s_time]}"
    concat_end = "#{params[:start_date]} #{params[:e_time]}"

    requested_start_time = Booking.convert_to_datetime(concat_start)
    requested_end_time = Booking.convert_to_datetime(concat_end)

    @availability = Booking.find_timeslot(requested_start_time, requested_end_time, @studio)
    price = Booking.total_price(requested_start_time, requested_end_time, @studio.price)

    if @availability
      @booking = @availability.bookings.new(start_time: requested_start_time, end_time: requested_end_time, user_id: session[:user_id], total_price: price)
      if @booking.save
        send_message_to_owner(current_user, @studio)
        flash[:notice] = "Your booking has been submitted."
        redirect_to studio_path(@studio)
      else
        flash[:errors] = @booking.errors.full_messages
        redirect_to studio_path(@studio)
      end
    else
      flash[:errors] = ['There are no availabilities that match those requested times.']
      redirect_to studio_path(@studio)
    end

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
