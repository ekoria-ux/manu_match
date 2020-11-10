class ArticlesController < ApplicationController
  include Pagy::Backend
  before_action :require_login

  def index
    @articles = Article.visible.order(created_at: :desc)
    @pagy, @favorite_articles = pagy(current_user.favorite_articles.includes(:author).visible.order(created_at: :desc))
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to @article, flash: { success: "記事を登録しました" }
    else
      render "new"
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article, flash: { success: "記事を更新しました" }
    else
      render "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to :articles, flash: { success: "記事を削除しました" }
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :date_hired_from, :date_hired_to, :status,
                                    :area, :category, :remark, :skill, :e_count, :expired_at)
  end
end
