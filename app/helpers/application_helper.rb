module ApplicationHelper

  def full_name(customer)
    customer.first_name + customer.last_name
  end

  def full_address(key)
    "#{key.postal_code}#{key.address}"
  end

  def current_cart
    @cart_items = current_customer.cart_items
  end

  def tax_price(price)
    (price * 1.1).floor
  end

  def subtotal(sub)
    (tax_price(sub.item.non_taxed_price) * sub.quantity)
  end

  def total_price(totals)
    price = 0
    totals.each do |total|
      price  +=  subtotal(total)
    end
    return price
  end

  def billing(order)
    total_price(current_cart) + order.postage
  end
end
