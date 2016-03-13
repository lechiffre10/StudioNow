class BookingsController < ApplicationController

  def new

  end

  def create
    @studio = Studio.find_by(id: params[:studio_id])
    @availability = Availability.find_by(id: 10)

    input_start_date = params[:start_date]
    input_start_time = params[:s_time]
    input_end_date = params[:end_date]
    input_end_time = params[:e_time]

    concat_start = "#{input_start_date} #{input_start_time}"
    concat_end = "#{input_end_date} #{input_end_time}"

    start_time = Booking.time_to_datetime(concat_start)
    end_time = Booking.time_to_datetime(concat_end)

    price = Booking.total_price(start_time, end_time, @studio.price)

    puts '**************'
    puts @studio.price

    @booking = @availability.bookings.new(start_time: start_time, end_time: end_time, user_id: session[:user_id], total_price: price)

    if @booking.save
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
