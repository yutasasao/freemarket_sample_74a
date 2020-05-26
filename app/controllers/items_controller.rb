class ItemsController < ApplicationController
  def index
    @item = Item.all.includes(:images)
    @images = Images.all
   
  end

  def new
    @item = Item.new 
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user
    @brand = @item.brand
    @prefecture = Prefecture.find(@item.shipping_area)
    @categories = @item.category
    @comments = @item.comments
    @comment = Comment.new
  end

  def bookmarks
    @bookmark = current_user.bookmark_items.includes(:user).recent
  end

  private

  def item_params
    params.require(:item).permit(:content)
  end
end
