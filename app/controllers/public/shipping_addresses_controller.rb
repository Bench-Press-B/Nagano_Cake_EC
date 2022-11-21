class Public::ShippingAddressesController < ApplicationController

  def index
    @address = ShippingAddress.where(customer:current_customer)
    @newaddress = ShippingAddress.new
  end

  def edit
    @address = ShippingAddress.find(params[:id])
  end

  def create
    @address = ShippingAddress.new(shipping_addresses_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to shipping_addresses_path
    end
  end

  def update
    @address = ShippingAddress.find(params[:id])
    if @address.update(shipping_addresses_params)
      redirect_to shipping_addresses_path
    else
      render "edit"
    end
  end

  def destroy
    @address = ShippingAddress.find(params[:id])
    @address.destroy
    redirect_to shipping_addresses_path
  end

  private

  def shipping_addresses_params
    params.require(:shipping_address).permit(:customer_id, :name, :postal_code, :address)
  end

  def correct_customer
    @shippingaddresses = ShippingAddress.find(params[:id])
    @customer = @shippingaddresses.customer
    redirect_to(about_path) unless @customer == current_user
  end
end
