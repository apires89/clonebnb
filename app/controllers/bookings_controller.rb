class BookingsController < ApplicationController
  def index
    @bookings = Boooking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def create
    @booking = Booking.new(bookings_params)
    if @booking.save
      flash[:notice] = "Reservation completed!"
      redirect_to root_path
    else
      flash[:blocked] = "That Date is not available"
      redirect_to :back
    end
  end

  def update
    @booking = Booking.find(params[:id])
    if params[:booking]
      @booking.update(booking_params)
    end
    redirect_to reservation_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    flash[:notice] = "Booking eliminated!"
    redirect_to(root_path)
  end

  #def bookingslot
  #end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :room_id, :start_date, :end_date)
    #needs more?
  end
end
