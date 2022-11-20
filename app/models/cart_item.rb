class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  def add_item(item_id:, quantity:)
    cart_item = CartItem.find_by(item_id: item_id) || CartItem.create(item_id: item_id)
    cart_item.quantity += quantity.to_i
    cart_item.save
  end
  
  def update_item(item_id:, quantity)
    item.find_by(item_id: item_id).
end
