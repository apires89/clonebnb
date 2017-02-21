class RoomsController < ApplicationController
<<<<<<< HEAD
   before_action :set_room, only: [:show, :edit, :update]
=======
>>>>>>> e20437a0164e48184732da60475325efdc116d42
  def new
  end

  def show
  end

  def index
  end

  def create
  end

  def update
  end

  def edit
  end
<<<<<<< HEAD

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(
      :home_type, :room_type, :accomodate,
     :bedrooms, :bathrooms, :summary, :address, :has_tv,
     :has_wifi, :has_kitchen, :has_heating, :has_aircon, :price, :activate )
  end
=======
>>>>>>> e20437a0164e48184732da60475325efdc116d42
end
