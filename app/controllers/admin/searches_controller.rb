class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  def search
    @query = { address_or_category_or_customer_name_cont: params[:q], move_method_eq: params[:move_method_eq], smoking_area_eq: params[:smoking_area_eq], toilet_eq: params[:toilet_eq] }
    @search = Rest.ransack(@query)
    @rests = @search.result.page(params[:page]).per(10)
  end
end
