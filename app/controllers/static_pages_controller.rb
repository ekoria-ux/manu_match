class StaticPagesController < ApplicationController
  def home
    @articles = Article.visible.order(created_at: :desc)
  end

  def about
  end
end
