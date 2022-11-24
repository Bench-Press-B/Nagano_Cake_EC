class Item < ApplicationRecord
  has_one_attached :image

  has_many :orders, through: :order_details
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  validates :name, length: {maximum:50}, uniqueness: true
  validates :explanation, length:{maximum:200}

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
