class FavoritesController < ApplicationController
  before_action :require_login
  before_action :set_article

  def create
    @favorite = current_user.favorites.build(article_id: @article.id)
    @favorite.save
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, article_id: @article.id)
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end
end
