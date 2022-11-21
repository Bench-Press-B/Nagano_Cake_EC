class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders.all
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
    @cart_items = current_customer.cart_items

    @order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method])

    # total_priceに請求額を入れる
    @order.total_price = billing(@order)
    
    # addressesに1が入っていれば（自宅）
    if params[:order][:addresses] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name

    # addressesに2が入っていれば（配送先一覧）
    elsif params[:order][:addresses] == "2"
      ship = Address.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address = ship.address
      @order.name = ship.name

    # addressesに3が入っていれば(新配送先)
    elsif params[:order][:addresses] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @ship = "1"

    # 有効かどうかの確認
      unless @order.valid? == true
        @addresses = Address.where(customer: current_customer)
        render :new
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_price)
  end

  def customer_params
    params.require(:order_details).permit(:taxed_price, :quantity, :status)

  end

  def billing(order)
    total_price(@cart_items = current_customer.cart_items) + postage
  end

  def subtotal
    (item.non_taxed_price * 1.1) *quantity
  end

end