class SalesController < ApplicationController
  
  def index
    @item = item.includes(:images).order('created_at DESC')
  end

  def new
    if user_signed_in?
      @item = Item.new
      @category = Category.where(ancestry: nil)
      @brand = Brandtype.all
      @condition = Condition.all
      @shipping_area = ShippingArea.all
      @shipping_method = ShippingMethod.all
      @item.images.build
    else
      redirect_to root_path
    end
  end

   # 以下全て、formatはjsonのみ
   # 親カテゴリーが選択された後に動くアクション
   def get_category_children
      #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
      @category_children = Category.find_by(id: params[:parent_id]).children
   end

   # 子カテゴリーが選択された後に動くアクション
   def get_category_grandchildren
   #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
      @category_grandchildren = Category.find(params[:child_id].to_s).children
   end

   def get_image
    @images = Item.find(params[:item_id]).images
   end
   
   def get_shipping_metod
    @shipping_method= if params[:shipping_price] == "送料込み(出品者負担)"
                      ShippingMethod.all
    end
  end


    def create
      
    end

  def show
  end
  
  private

    def item_params
      params.require(:item).permit(:name, :price, :size_id, :explanation, :condition_id, :shipping_date, :shipping_price, :shipping_area_id, :shipping_method_id, :category_id, :brand_id, :user_id, images_attributes: [:id, :image, :_destroy]) #編集や削除の際に必要になるためid, :_destoryを記載する
    end

  end

