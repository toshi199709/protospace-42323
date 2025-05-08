class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.prototype_id = params[:prototype_id]
  
    @prototype = Prototype.find(params[:prototype_id])
    @comments = @prototype.comments.includes(:user)
  
    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      render 'prototypes/show' # ←これで詳細ページに戻る！
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end