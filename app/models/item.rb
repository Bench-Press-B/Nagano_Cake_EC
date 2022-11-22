class Item < ApplicationRecord
  has_one_attached :image

  has_many :orders, through: :order_details
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
