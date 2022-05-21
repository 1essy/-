class Public::NoticesController < ApplicationController
  def index
    @notices = current_customer.passive_notices.page(params[:page]).per(10)
    @notices.where(checked: false).each do |notice|
      notice.checked = true
      notice.save
    end
  end
  
  def destroy
    @notices = current_customer.passive_notices.destroy_all
    redirect_to notices_path
  end
end
