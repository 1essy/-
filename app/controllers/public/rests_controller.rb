class Public::RestsController < ApplicationController
  before_action :correct_rest, only: [:edit, :update]
  def index
    redirect_to root_path
  end

  def show
    @rest_comment = RestComment.new
    @rest = Rest.find(params[:id])
    if current_customer.present?
      view_count = ViewCount.find_by(customer_id: current_customer.id, rest_id: @rest.id)
      current_customer.view_counts.create(rest_id: @rest.id) if view_count.nil?
    end
  end

  def search_rest
     @rests = Rest.search(params[:keyword]).page(params[:page]).per(10)
  end

  def new
  end

  def edit
  end

  def update
    if  @rest.update(rest_params)
      redirect_to rest_path(@rest), notice: "投稿を更新しました"
    else
      render :edit
    end
  end

  def create
    @rest = Rest.new(rest_params)
    @rest.customer_id = current_customer.id
    if  @rest.save
      redirect_to rest_path(@rest), notice: "投稿しました"
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
    params.require(:rest).permit(:describe, :move_method, :smoking_area, :toilet, :image, :address, :category).merge(customer_id: current_customer.id)
  end
  def ensure_correct_customer
      @rest = Rest.find(params[:id])
      unless @rest.customer == current_customer
        redirect_to root_path
      end
  end
  def search_params
    params.require(:q).permit(:address_cont)
  end

  def correct_rest
    @rest = Rest.find(params[:id])
    if current_customer != @rest.customer
      redirect_to customer_path(current_customer)
    end
  end


end
