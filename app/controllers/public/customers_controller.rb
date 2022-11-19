class Public::CustomersController < ApplicationController
  def show
    @editcustomer = Customer.new
    @customer = Customer.find(params[:id])
  end
  
  def customer_params
    params.require(:customer).permit(:first_name, :last_name)
  end
end
