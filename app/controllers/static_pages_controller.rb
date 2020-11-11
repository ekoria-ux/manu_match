class StaticPagesController < ApplicationController
  def home
    @articles = Article.includes([:author]).visible.order(created_at: :desc)
  end

  def about
  end
end
