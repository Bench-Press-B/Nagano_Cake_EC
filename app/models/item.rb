class Item < ApplicationRecord
  has_one_attached :image
  
  has_many :cart_items, dependent: :destroy

  belongs_to :genre

  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
end
