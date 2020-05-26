class Image < ApplicationRecord
  belongs_to :item
  belongs_to :bookmark
  # ↑optional: true　imageを独立させる
  mount_uploader :image, ImageUploader
  belongs_to :item, optional: true

  validates :image, presence: true
  
end
