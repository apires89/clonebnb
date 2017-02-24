class UsersController < ApplicationController


  def update
    @user = User.find(params[:id])
    if params[:user]
      @user.update(user_params)
    end
      redirect_to user_path
  end

  def show
    @user = current_user
    @rooms = @user.rooms
    @bookings = @user.bookings
  end


private
  def user_params
    params.require(:user).permit(:avatar, :bio, :location)
  end
end
