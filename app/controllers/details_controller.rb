class DetailsController < ApplicationController
  def index
    @details = Detail.all
  end
  
  def show
    @details = Detail.find(params[:id])
  end

  def destroy
    @details = Detail.find(params[:id])
    @details.destroy
    redirect_to details_path
  end
end