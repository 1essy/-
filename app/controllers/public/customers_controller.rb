class Public::CustomersController < ApplicationController
  before_action :ensure_guest_customer, only: [:edit]
  

  def withdrawal#退会機能
    #binding.pry
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: false)
    reset_session
    flash[:alert] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def guest_sign_in
    
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: 'ゲストでログインしました。'
  end

  def index
    redirect_to new_customer_registration_path
  end

  def show
    @customer = Customer.find(params[:id])
    @rests = @customer.rests.page(params[:page]).per(12)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = current_customer
    if  @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "ユーザー情報を更新しました"
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :password, :is_deleted)
  end

  def correct_customer
    @customer = Customer.find(params[:id])
    if current_customer != @customer
      redirect_to customer_path(current_customer)
    end
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestcustomer"
      redirect_to customer_path(current_customer) , alert: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
