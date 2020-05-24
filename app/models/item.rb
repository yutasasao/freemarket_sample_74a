class Item < ApplicationRecord
  has_many :images
  accepts_nested_attributes_for :images

def show_soldout_item(item)
  if (soldout_item = item.buyer_id).present?
    'SOLD'
    end
end



end
