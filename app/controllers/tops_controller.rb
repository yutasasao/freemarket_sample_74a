class TopsController < ApplicationController
  def index
    @items = Item.all.includes(:images)
    # @items.images.build
    # binding.pry
  end
end
