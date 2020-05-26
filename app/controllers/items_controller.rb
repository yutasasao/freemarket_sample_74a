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

class ItemsController < ApplicationController

  def index
    @item = Item.all.includes(:images)
    # @images = Images.all
   
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
        @items = Item.all
        render 'sales/new'
      end
    end

    def show
      @item = Item.find(params[:id])
    end

  private

  def item_params
    params.require(:item).permit(:name, :price, :explanation, :condition_id, :shipping_date, :shipping_price, :shipping_area_id, :shipping_method_id, :category_id, :brand_id, images_attributes: [:id, :image, :_destroy]).merge(user_id: current_user.id, saler_id: current_user.id,)#編集や削除の際に必要になるためid, :_destoryを記載する
  end

end