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

  def edit
    @item = Item.find(params[:id])
    @images = @item.images
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
  end

end  
