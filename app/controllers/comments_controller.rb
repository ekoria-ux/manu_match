class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_article

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.article_id = params[:article_id]
    @comment.save
    redirect_to @article
  end

  def destroy
    @comment = Comment.find_by(user_id: current_user.id, article_id: @article.id)
    @comment.destroy
    redirect_to @article
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
