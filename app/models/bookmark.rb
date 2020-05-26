class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :images
  validates :user_id, uniqueness: { scope: :item_id }
end
