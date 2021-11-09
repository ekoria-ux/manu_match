class StaticPagesController < ApplicationController
  include Pagy::Backend

  def home
    @pagy, @articles = pagy(Article.includes([:author]).visible.published.order(created_at: :desc))
    if params[:search]
      @pagy, @articles = pagy(
        Article.search(params[:search]).visible.published.order(created_at: :desc)
      )
    end
  end

  def about
  end

  def term
  end
end
