class BookingsController < ApplicationController

  def new

  end

  def create
    @studio = Studio.find_by(id: params[:studio_id])
    @availability = Availability.find_by(id: params[:availability_id])
    @booking = Booking.create(booking_params)
    if @booking.save
      redirect_to studio_path(@studio), notice: "Your booking has been submitted."
    end
  end

  def destroy

  end


  private
  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :availability_id)
  end


end
