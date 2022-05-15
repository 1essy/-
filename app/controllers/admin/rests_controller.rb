class Admin::RestsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_q, only: [:search]
  
  def search
    @search = Rest.ransack(params[:q])
    @rests = @search.result.page(params[:page]).per(10)
  end
  
  def index
    @search = Rest.ransack(params[:q])
    @rests = @search.result.page(params[:page]).per(10)
    
  end

  def show
    @rest = Rest.find(params[:id])
    unless ViewCount.find_by(customer_id: current_customer.id, rest_id: @rest.id)
      current_customer.view_counts.create(rest_id: @rest.id)
    end
  end

  def new
  end

  def edit
  end
  
  def destroy
    @rest = Rest.find(params[:id])
    @rest.destroy
    redirect_to admin_rests_path(current_customer), alert:"投稿を削除しました"
  end
  
  private
  
  def set_q
    @search = Rest.ransack(params[:q])
  end

  def rest_params
    params.require(:rest).permit(:describe, :move_method, :smoking_area, :toilet, :image)
  end
end
