
class Public::CustomersController < ApplicationController
  # before_action :authenticate_user!, except: [:top, :about]
  # before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @editcustomer = Customer.new
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name)
  end

end
