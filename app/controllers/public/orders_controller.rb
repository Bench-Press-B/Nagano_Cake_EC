class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end

  def index
    #@orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  
  def create
    @order = current_customer.orders.new(order_params)
    @order.save
  end
  
  def thanx
  end
  
  def confirm
    
  end


end