class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    flash[:notice] = "注文ステータスの変更をしました"
    redirect_to admin_order_path(@order)

  end

  def order_params
    params.require(:order).permit(:name,:shipping_cost,:total_price,:payment_method,:status,:address,:postal_code,:making_status)
  end

end
