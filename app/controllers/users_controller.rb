class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
    @item = @user.items
  end

  def sale_list
    user = User.find(params[:id])
    @item = user.items
    @user_items = @item.where(buyer_id: nil).includes(:images).order("created_at DESC")
  end

end
