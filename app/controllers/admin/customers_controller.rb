class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    @rests = @customer.rests.page(params[:page]).per(12)
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice:"ユーザー情報を更新しました"
    else
      redirect_to edit_admin_customer_path(@customer)
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :email, :password, :is_deleted)
  end
end
