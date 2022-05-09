class Public::FavoritesController < ApplicationController
  def create
    @rest = Rest.find(params[:rest_id])
    favorite = current_customer.favorites.new(rest_id: @rest.id)
      favorite.save
  end

  def destroy
    @rest = Rest.find(params[:rest_id])
    favorite = current_customer.favorites.find_by(rest_id: @rest.id)
    favorite.destroy

  end
end
