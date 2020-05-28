class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true    #build使用のため
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  belongs_to :category, optional: true
  belongs_to :brand, optional: true
  belongs_to :user, optional: true
  # optional: true　初期のpresentバリデーション回避

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_area
  belongs_to_active_hash :shipping_method
  belongs_to_active_hash :brandtype
  belongs_to_active_hash :shipping_date
  belongs_to_active_hash :shipping_price
 


  validates :condition_id, :shipping_area_id, :shipping_method_id, numericality: {only_integer: true, greater_than: 0, message: "を選択して下さい"}
  validates :shipping_date, :shipping_price, :category_id, presence: {message: "を選択して下さい"}
  validates :name, length: { minimum: 1, maximum: 40, message: "は40文字以内で入力してください" }
  validates :explanation, length: { minimum: 1, maximum: 1000, message: "は1000文字以内で入力してください" }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "を半角数字で300〜9,999,999に収まるよう入力してください" }
  # validates :images, presence: {message: "をアップロードして下さい"}

  def show_soldout_item(item)
    if (soldout_item = item.buyer_id).present?
      'SOLD'
      end
  end

  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

end
