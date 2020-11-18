class StaticPagesController < ApplicationController
  include Pagy::Backend

  def home
    @pagy, @articles = pagy(Article.includes([:author]).visible.order(created_at: :desc))
    if params[:search]
      @pagy, @articles = pagy(Article.search(params[:search]).visible.order(created_at: :desc))
    end
  end

  def about
  end

  def term
  end
end
