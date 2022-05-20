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
      redirect_to admin_customers_path, notice:"ユーザー情報を更新しました"
    else
      render :edit
    end
  end
  
  #def destroy_all
    
    #@rests = @customer.rests
    #@rests.destroy_all
    #redirect_to request.referer
  #end

  private
  def customer_params
    params.require(:customer).permit(:name, :email, :password, :is_deleted, :profile_image)
  end
end
