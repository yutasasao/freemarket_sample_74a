class BuyController < ApplicationController
  before_action :set_user, only: [:index, :done] 


  def index
  end

  def done
  end


  private
  def set_user
    @item = Item.find(params[:item_id])
  end
end
