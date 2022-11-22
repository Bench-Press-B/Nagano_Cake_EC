class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path
    else
      render "edit"
    end
  end
  
  def unsubscribe
    @customer = Customer.find(params[:id])
  end
  
  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :kana_first_name, :kana_last_name, :email, :postal_code, :address, :phone_number, :is_deleted)
  end

  def ensure_correct_user
   @customer = Customer.find(params[:id])
   unless @customer == current_user
     redirect_to customer_path(current_user)
   end
  end
  
  def reject_user
    @customer = Customer.find_by(name: params[:customer][:first_name][:last_name])
    if @customer 
      if @customer.valid_password?(params[:customer][:encrypted_password]) && (@customer.is_deleted == false)
        redirect_to new_customer_registration
      end
    end
  end
end
