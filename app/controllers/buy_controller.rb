class BuyController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
  end

  def done
    @item = Item.find(params[:item_id])
  end

end
