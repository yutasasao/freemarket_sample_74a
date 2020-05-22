class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  

  validates :postal_code, :prefecture_id, :city, :street, :first_name, :last_name, :first_name_kana, :last_name_kana, presence: true
  validates :first_name_kana, :last_name_kana, format: {
    with: /\A[\p{hiragana}　ー－&&[^ -~｡-ﾟ]]+\z/,
  }
  validates :first_name, :last_name, format: {
    with: /[^ -~｡-ﾟ]+/,
  }
  validates :prefecture_id,format: {
    with: /[1-47]+/,
  }
  validates :postal_code, format: {
    with: /\A\d{3}[-]\d{4}$|^\d{3}[-]\d{2}$|^\d{3}$|^\d{5}$|^\d{7}\z/,
  }
end
