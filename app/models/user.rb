class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :nickname, :encrypted_password, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday, presence: true
  validates :encrypted_password, length: { minimum: 7 }
  # validates :encrypted_password, format: {
  #   with: /\A[a-z0-9]+\z/,
  #   message: "半角英数字のみで連続した文字を避けて入力してください"
  # }
  validates :nickname, uniqueness: true
  validates :first_name_kana, :last_name_kana, format: {
    with: /\A[\p{hiragana}　ー－&&[^ -~｡-ﾟ]]+\z/,
    message: "全角ひらがなのみで入力して下さい"
  }
  validates :first_name, :last_name, format: {
    with: /[^ -~｡-ﾟ]+/,
    message: "全角で入力して下さい"
  }


end
