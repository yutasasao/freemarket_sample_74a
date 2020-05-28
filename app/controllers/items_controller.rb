class ItemsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

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
      if @item.valid? && params[:images].present?
        @item.save
        params[:images][:image].each do |image|
          @item.images.create(image: image, item_id: @item.id)
        end
        redirect_to root_path
      else
        @category = Category.where(ancestry: nil)
        @condition = Condition.all
        @brand = Brandtype.all
        @shipping_area = ShippingArea.all
        @shipping_method = ShippingMethod.all
        @item.images.build
        render 'sales/new'
      end
  end



  def show
    @user = @item.user
    @brand = Brandtype.find(@item.brand_id)
    @prefecture = Prefecture.find(@item.shipping_area_id)
    @condition = Condition.find(@item.condition_id)
    @shippingprice = ShippingPrice.find(@item.shipping_price_id)
    @shippingmethod = ShippingMethod.find(@item.shipping_method_id)
    @shippingdate = ShippingDate.find(@item.shipping_date_id)
    @categories = @item.category
    @comments = @item.comments
    @comment = Comment.new
  end

  def edit
    @images = @item.images
    @category = Category.where(ancestry: nil)
    @brand = Brandtype.all
    @condition = Condition.all
    @shipping_area = ShippingArea.all
    @shipping_method = ShippingMethod.all
    @item.images.build
  end

  def update
     if params[:images][:image].nil?
       redirect_to edit_item_path(params[:id])
     else @item.update(item_params)
      exist_ids = @item.images.pluck(:id)
      params[:images][:image].each do |image|
        if image.is_a?(String)
          exist_ids.delete(image.to_i)
        else
          render :edit unless @item.images.create(image: image, item_id: @item.id)
        end
      end
      exist_ids.each do |id|
        delete_image = Image.find(id)
        delete_image.delete
      end
      redirect_to root_path
  end
end

  def bookmarks
    @bookmark = current_user.bookmark_items.includes(:user).recent
  end


  private
  def set_user
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :explanation, :condition_id, :shipping_date_id, :shipping_price_id, :shipping_area_id, :shipping_method_id, :category_id, :brand_id, :content, images_attributes: [:id, :image, :_destroy]).merge(user_id: current_user.id, saler_id: current_user.id,)#編集や削除の際に必要になるためid, :_destoryを記載する
  end

end
