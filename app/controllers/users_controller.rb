class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  before_action :set_user, only: [ :show ]
  before_action :check_current_user, only: [ :edit, :update ]

  def show
    @events = @user.events.order(created_at: :desc)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_current_user
    redirect_to root_path, alert: "You can only edit your own profile." unless params[:id].to_i == current_user.id
  end

  def user_params
    params.require(:user).permit(:name, :bio, :profile_picture)
  end
end
