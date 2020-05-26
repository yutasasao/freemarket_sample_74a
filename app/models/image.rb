class Image < ApplicationRecord
  belongs_to :item
  belongs_to :bookmark
end
