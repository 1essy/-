class Public::RestCommentsController < ApplicationController
  def create
    @rest = Rest.find(params[:rest_id])
    @comment = current_customer.rest_comments.new(rest_comment_params)
    @comment.rest_id = @rest.id
    @comment.save
    redirect_to rest_path(@rest), notice: 'コメントを投稿しました'
  end

  def destroy
    RestComment.find(params[:id]).destroy
    redirect_to rest_path(params[:rest_id]), alert: 'コメントを削除しました'
  end

  private
  def rest_comment_params
    params.require(:rest_comment).permit(:comment, :star)
  end
end
