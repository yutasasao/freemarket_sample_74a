class ItemsController < ApplicationController
  def index
    @item = Item.all.includes(:images)
    @images = Images.all
   
  end

  def new
    @item = Item.new 
    @item.images.build
  end

  def show
    @item = Item.find(params[:id])
  end
end
