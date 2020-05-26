class Brand < ApplicationRecord

  # extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :brandtype



  has_many :items

end
