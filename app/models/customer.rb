class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :kana_first_name, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :kana_last_name, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :postal_code, presence: true, numericality: true, length: {is: 7}
  validates :phone_number, presence: true
  validates :address, presence: true
  validates :email, presence: true


  has_many :orders
  has_many :cart_items, dependent: :destroy
  has_many :shipping_addresses, dependent: :destroy

  def full_name
    self.first_name + " " + self.last_name
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

end
