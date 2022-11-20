class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = current_user.cart_items
  end
  
  def update
    
  end
  
  
  def destroy
  end
  
  def all_destroy
  end
  
  def create
  end
  
end
