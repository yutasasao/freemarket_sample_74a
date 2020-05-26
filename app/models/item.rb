class Item < ApplicationRecord
  has_many :images
  accepts_nested_attributes_for :images
  has_many :comments
  has_many :bookmarks, dependent: :destroy
  belongs_to :category
  belongs_to :brand
  belongs_to :user

  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  def show_soldout_item(item)
    if (soldout_item = item.buyer_id).present?
      'SOLD'
      end
  end

end
