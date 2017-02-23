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
    @room = Room.find(params[:room_id])

    @booking = Booking.new(
      start_date: datepicker_to_date(params[:booking][:start_date]),
      end_date: datepicker_to_date(params[:booking][:end_date]),
      num_of_persons: params[:booking][:num_of_persons]
      )
    @booking.room = @room
    @booking.user = current_user
    if @booking.save
      flash[:notice] = "Reservation completed!"
      redirect_to root_path
    else
      flash[:alert] = "That time period is not available"
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

  def datepicker_to_date(datepicker_string)
    datepicker_string.gsub('/','-')
  end

end
