class Admin::RestsController < ApplicationController
  def index
    @rests = Rest.page(params[:page]).per(10)
    
  end

  def show
    @rest = Rest.find(params[:id])
   
  end

  def new
  end

  def edit
  end
  
  def destroy
    @rest = Rest.find(params[:id])
    @rest.destroy
    redirect_to admin_rests_path(current_customer)
  end
  
  private

  def rest_params
    params.require(:rest).permit(:describe, :move_method, :smoking_area, :toilet, :image)
  end
end
