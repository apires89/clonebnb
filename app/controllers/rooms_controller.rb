class RoomsController < ApplicationController
before_action :set_room, only: [:show, :edit, :update]

# User must be authneticated before every controller action, except for show
  before_action :authenticate_user!, except: [:show]


  def new
    @room = current_user.rooms.build
  end

  def show

    @photos = @room.photo


    @room = Room.find(params[:id])
    @alert_message = "You are viewing #{@room.name}"
    @photos = @room.photo

    @reviews = @room.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user

  end

  def index
    @rooms = current_user.rooms
    @rooms = Room.where.not(latitude: nil, longitude: nil)
    @hash = Gmaps4rails.build_markers(@flats) do |flat, marker|
      marker.lat flat.latitude
      marker.lng flat.longitude
    end
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      if params[:images]
        params[:images].each do |image|
          @room.photo.create(image: image)
        end
      end
      @photos = @room.photo
      redirect_to edit_room_path (@room), notice: "Saved Room Picture."
    else
      render :new
    end
  end

  def update
    if @room.update(room_params)
      if params[:images]
        params[:images].each do |image|
          @room.photo.create(image: image)
        end
      end
      redirect_to edit_room_path(@room), notice: "Room updated successfully."
  end
end
  def edit
    if current_user.id == @room.user.id
      @photos = @room.photo
    else

      redirect_to :index, notice: "You can't make changes to this room."

    end
  end

  private

  def set_room
  @room = Room.find(params[:id])
  end

  def room_params
  params.require(:room).permit(
  :home_type, :room_type, :accomodate,
  :bedrooms, :bathrooms, :summary, :address, :has_tv,
  :has_wifi, :has_kitchen, :has_heating, :has_aircon, :price, :activate, :photo_cache, :url, photos: [] )
  end
end
