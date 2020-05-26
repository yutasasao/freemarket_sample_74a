class TopsController < ApplicationController
  def index
    @items = Item.all.includes(:images)
  end
  
  def show
  end
end
