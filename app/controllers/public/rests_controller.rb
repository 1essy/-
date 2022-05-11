class Public::RestsController < ApplicationController
  before_action :authenticate_customer!
  before_action :correct_rest, only: [:edit, :update]

  def index
    redirect_to root_path
  end

  def show
    @rest = Rest.find(params[:id])
    @rest_comment = RestComment.new
  end

  def new
  end

  def edit
  end

  def update
    @rest.update(rest_params)
    redirect_to rest_path(@rest), notice: "投稿を更新しました"
  end

  def create
    @rest_new = Rest.new(rest_params)
    @rest_new.customer_id = current_customer.id
    if  @rest_new.save
      redirect_to rest_path(@rest_new), notice: "投稿しました"
    else
      render template: "public/homes/top"
    end
  end

  def destroy
    @rest = Rest.find(params[:id])
    @rest.destroy
    redirect_to customer_path(current_customer), alert: "投稿を削除しました"
  end

  private

  def rest_params
    params.require(:rest).permit(:describe, :move_method, :smoking_area, :toilet, :image)
  end
  def ensure_correct_user
      @rest = Rest.find(params[:id])
      unless @rest.user == current_customer
        redirect_to root_path
      end
  end

  def correct_rest
    @rest = Rest.find(params[:id])
    if current_customer != @rest.customer
      redirect_to customer_path(current_customer)
    end
  end
end
