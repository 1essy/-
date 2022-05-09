class Admin::RestCommentsController < ApplicationController
  def destroy
    RestComment.find(params[:id]).destroy
    redirect_to admin_rest_path(params[:rest_id]), alert: 'コメントを削除しました'
  end
  private
  def rest_comment_params
    params.require(:rest_comment).permit(:comment)
  end
end
