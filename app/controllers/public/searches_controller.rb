class Public::SearchesController < ApplicationController
 
  def search
    @search = Rest.ransack(params[:q])
    @rests = @search.result.page(params[:page]).per(10)
  end
end
  
