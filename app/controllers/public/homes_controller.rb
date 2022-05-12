class Public::HomesController < ApplicationController
  
  def top
    #@rest = Rest.find(params[:id])
    @rest_new = Rest.new

  end
  
  def about
  end
  
  private

 
end
