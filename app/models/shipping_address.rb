class ShippingAddress < ApplicationRecord

  belongs_to :customer
  
  validates :postal_code, presence: true
  validates :name, presence: true
  validates :address, presence: true

  def order_address
    "〒" + self.postal_code + "   " + self.address+ "   " + self.name
  end

end
