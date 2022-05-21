class Public::RestCommentsController < ApplicationController
  def create
    @rest = Rest.find(params[:rest_id])
    @rest_comment = current_customer.rest_comments.new(rest_comment_params)
    @rest_comment.rest_id = @rest.id
    if  @rest_comment.save
        @rest.create_notice_rest_comment!(current_customer, @rest_comment.id)
      redirect_to rest_path(@rest), notice: 'コメントを投稿しました'
    else
        render template: "public/rests/show"
    end
  end
  
  def index
    @rest = Rest.find(params[:rest_id])
    redirect_to rest_path(@rest)
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
