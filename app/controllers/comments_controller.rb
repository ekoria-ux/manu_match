class CommentsController < ApplicationController
  before_action :require_login

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @article.create_notification_comment(current_user, @comment.id)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js { render :index }
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js { render :index }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
