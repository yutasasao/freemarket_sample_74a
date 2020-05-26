class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :shipping_method
 
  # optional: true　初期のpresentバリデーション回避
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  belongs_to :brand, optional: true
  
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true #build使用のため

  validates :condition_id, :shipping_area_id, :shipping_method_id, numericality: {only_integer: true, greater_than: 0}
  validates :shipping_date, :shipping_price, :user_id, :category_id, presence: true
  validates :name, length: { minimum: 1, maximum: 40, message: "は40文字以内で入力してください" }
  validates :explanation, length: { minimum: 1, maximum: 1000, message: "は1000文字以内で入力してください" }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "半角数字で300〜9,999,999に収まるよう入力してください" }
  

  def show_soldout_item(item)
    if (soldout_item = item.buyer_id).present?
      'SOLD'
      end
  end

end
