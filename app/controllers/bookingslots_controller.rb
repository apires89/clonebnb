class BookingslotsController < ApplicationController

  def show
    @bookingslot = Bookingslot.find(params[:id])
  end

  private
  def bookingslot_from_id
    @bookingslot = Bookingslot.find(params[:id])
  end

  def bookingslot_params
        params.require(:bookingslot).permit(:date,:day_price,:room_id)
  end

end
