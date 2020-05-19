class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.where(user_id: current_user.id)
    @users = User.find(params[:id])
  end

end
