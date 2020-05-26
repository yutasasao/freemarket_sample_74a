class Image < ApplicationRecord

  # ↑optional: true　imageを独立させる
  mount_uploader :image, ImageUploader
  belongs_to :item, optional: true

  validates :image, presence: {message: "をアップロードして下さい"}
  
end
