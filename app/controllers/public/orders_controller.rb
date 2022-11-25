class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def new
    @order = Order.new
    @addresses = current_customer.shipping_addresses
  end

  def index
    @orders = current_customer.orders.page(params[:page]).per(10)
    @order_detail = OrderDetail.where(customer:current_customer)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @sum = 0
    @subtotals = @order_details.map { |order_details| order_details.taxed_price * order_details.quantity }
    @sum = @subtotals.sum
  end

  def thanx
  end

  def confirm
    @cart_items = current_customer.cart_items

    @order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method])

    @order.total_price = billing(@order)

    if params[:order][:addresses] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    elsif params[:order][:addresses] == "2"
      ship = ShippingAddress.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address = ship.address
      @order.name = ship.name

    elsif params[:order][:addresses] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @shipping = "1"

      unless @order.valid? == true
        @addresses = ShippingAddress.where(customer: current_customer)
        render :new
      end
    end
  end

  def create
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @item = cart_item.item
    end
    if @item.is_active?
      @order = current_customer.orders.new(order_params)
      @order.save

      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.order_id = @order.id
        @order_detail.quantity = cart_item.quantity
        @order_detail.taxed_price = cart_item.item.non_taxed_price * 1.1
        @order_detail.save
      end

      @cart_items.destroy_all

      redirect_to thanx_orders_path

    else
      redirect_to cart_items_path
      flash[:notice]="販売停止中の商品が含まれています。"
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_price)
  end

  def order_detail_params
    params.require(:order_detail).permit(:taxed_price, :quantity, :status, :order_id, :item_id)
  end

  def item_params
    params.require(:item).permit(:name)
  end

  def shipping_address_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name)
  end

end