class Image < ApplicationRecord
<<<<<<< Updated upstream
  belongs_to :item
=======
  # ↑optional: true　imageを独立させる
  mount_uploader :image, ImageUploader
  belongs_to :item, optional: true

  validates :image, presence: true
>>>>>>> Stashed changes
end
