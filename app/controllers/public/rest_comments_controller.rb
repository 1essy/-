class Public::RestCommentsController < ApplicationController
  def create
    rest = Rest.find(params[:rest_id])
    comment = current_customer.rest_comments.new(rest_comment_params)
    comment.rest_id = rest.id
    comment.save
    redirect_to rest_path(rest)
  end
  
  def destroy
    RestComment.find(params[:id]).destroy
    redirect_to rest_path(params[:rest_id])
  end
  
  private
  def rest_comment_params
    params.require(:rest_comment).permit(:comment)
  end
end
