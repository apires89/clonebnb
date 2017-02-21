class BookingslotsController < ApplicationController
  def index
  end

  def show
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
end
