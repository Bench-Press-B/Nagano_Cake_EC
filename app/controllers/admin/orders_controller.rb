class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!


  def index
    @orders = Order.page(params[:page]).per(10)
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

    if @order.status == "入金確認"
      @order.order_details.each do |order_detail|
        order_detail.update(status: 1)
      end
    end
  end

  def order_params
    params.require(:order).permit(:name,:shipping_cost,:total_price,:payment_method,:status,:address,:postal_code,:making_status)
  end

end
