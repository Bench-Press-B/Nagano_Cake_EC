class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

 validates :customer_id, :item_id, :quantity, presence: true
 validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

end
