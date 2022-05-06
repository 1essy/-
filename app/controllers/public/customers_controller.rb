class Public::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    #@customer = Customer.find(params[:id])
    @customer = current_customer
    @rests = @customer.rests
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = current_customer
    if  @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render "edit"
    end
  end    
      
  def withdrawal　#退会機能
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  private

  def customer_params
    params.require(:customer).permit(:name, :email, :password)
  end

  def correct_customer
    @customer = Customer.find(params[:id])
    if current_customer != @customer
      redirect_to customer_path(current_customer)
    end
  end
end
