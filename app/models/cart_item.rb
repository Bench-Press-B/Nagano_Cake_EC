class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item
  
  def subtotal
    (item.non_taxed_price * 1.1) *quantity
  end

end
