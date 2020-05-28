class UsersController < ApplicationController
  before_action :set_user, only: [:show, :sale_list]

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def sale_list
    @user_items = @item.where(buyer_id: nil).includes(:images).order("created_at DESC")
  end

  private
  def set_user
    @user = User.find(params[:id])
    @item = @user.items
  end
end

