class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 7..128

  has_one :address, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: {
    with: VALID_EMAIL_REGEX
  }
  validates :nickname, :encrypted_password, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday, presence: true
  validates :nickname, uniqueness: true
  validates :first_name_kana, :last_name_kana, format: {
    with: /\A[\p{hiragana}　ー－&&[^ -~｡-ﾟ]]+\z/,
  }
  validates :first_name, :last_name, format: {
    with: /[^ -~｡-ﾟ]+/,
  }

end
