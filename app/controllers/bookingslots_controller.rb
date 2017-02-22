class BookingslotsController < ApplicationController
  def index
  end

  def show
    @bookingslot = Bookingslot.find(params[:id])
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end


  private
  def bookingslot_from_id
    @bookingslot = Bookingslot.find(params[:id])
  end

  def bookingslot_params
        params.require(:bookingslot).permit(:date,:day_price,:room_id)
  end

end
