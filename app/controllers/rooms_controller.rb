class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]
# User must be authneticated before every controller action, except for show
  before_action :authenticate_user!, except: [:show]


  def new
    @room = Room.new
  end

  def show
    @booking = Booking.new
    @room = Room.find(params[:id])
    @alert_message = "You are viewing #{@room.name}"

    @photos = @room.photos

    @reviews = @room.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def search
    if Room.near(params[:address], 1000).empty?
      notice
      redirect_to rooms_path, alert: "No results found! Please search again."
    else
      @rooms = Room.near(params[:address], 500)
      flash[:notice] =  "#{@rooms.length} results found!"

    end
    @hash = Gmaps4rails.build_markers(@rooms) do |flat, marker|
      marker.lat flat.latitude
      marker.lng flat.longitude
      marker.infowindow flat.name
    end
  end

  def index
    @rooms = current_user.rooms
    @rooms = Room.where.not(latitude: nil, longitude: nil)
    @hash = Gmaps4rails.build_markers(@rooms) do |flat, marker|
      marker.lat flat.latitude
      marker.lng flat.longitude
      marker.infowindow flat.name
    end
  end

  def create
    raise
    @room = current_user.rooms.build(room_params)
    if params[:room][:start_date].length == 0 || params[:room][:end_date].length == 0
      render :new, alert: "Insert dates."
      return
    end
    day = datepicker_to_date(params[:room][:start_date])
    end_date = datepicker_to_date(params[:room][:end_date])
    if day < end_date
      render :new, alert: "Choose correct dates."
      return
    end
    price = params[:room][:price]
    if @room.save && day < end_date
      if params[:images]
        params[:images].each do |image|
          @room.photo.create(image: image)
        end
      end
      @photos = @room.photos
      while !(day === end_date)
        slot = BookingSlot.new(date: day.to_s(:db), day_price: price)
        slot.room = @room
        slot.save!
        day = day + 1
      end
      redirect_to user_profile_path, notice: "Saved Room."
    else
      render :new, alert: "Room not saved."
    end
  end

  def update
    if @room.update(room_params)
      if params[:images]
        params[:images].each do |image|
          @room.photo.create(image: image)
        end
      end
      redirect_to user_profile_path, notice: "Room updated successfully."
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
  :name, :home_type, :room_type, :accomodate, :description,
  :bedrooms, :bathrooms, :summary, :address, :has_tv,
  :has_wifi, :has_kitchen, :has_heating, :has_aircon, :price, :activate, :photo_cache, :url, photos: [] )
  end

  def datepicker_to_date(datepicker_string)
    Date.strptime(datepicker_string.gsub('/','-'), '%d-%m-%Y')
  end
end
