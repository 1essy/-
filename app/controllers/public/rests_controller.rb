class Public::RestsController < ApplicationController
  def index
  end

  def show
    @rest = Rest.find(params[:id])
    @rest_comment = RestComment.new
  end

  def new
  end

  def edit
    @rest = Rest.find(params[:id])
  end

  def update
    @rest = Rest.find(params[:id])
    if  @rest.update(rest_params)
      redirect_to rest_path(@rest), notice: "投稿を更新しました"
    else
      render "edit"
    end
  end

  def create
    @rest = Rest.new(rest_params)
    @rest.customer_id = current_customer.id
    if  @rest.save
      redirect_to rest_path(@rest), notice: "投稿しました"
    else
      render root_path
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
end
