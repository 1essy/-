class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @customer = current_customer
    @rests = @customer.favorites_rests.page(params[:page]).per(12)
  end

  def create
    @rest = Rest.find(params[:rest_id])
    favorite = current_customer.favorites.new(rest_id: @rest.id)
    favorite.save
    @rest.create_notice_favorite!(current_customer)
  end

  def destroy
    @rest = Rest.find(params[:rest_id])
    favorite = current_customer.favorites.find_by(rest_id: @rest.id)
    favorite.destroy
  end
end
