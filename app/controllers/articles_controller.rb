class ArticlesController < ApplicationController
  before_action :require_login, except: [:index]

  def index
    @articles = Article.order(created_at: :desc)
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
    @article.assign_attributes(article_params)
    if @article.save
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
    params.require(:article).permit(:title, :body, :date_hired_from, :date_hired_to,
                                    :area, :category, :remark, :skill, :e_count, :expired_at)
  end
end
