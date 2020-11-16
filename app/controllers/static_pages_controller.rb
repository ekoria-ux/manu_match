class StaticPagesController < ApplicationController
  include Pagy::Backend

  def home
    @pagy, @articles = pagy(Article.includes([:author]).visible.order(created_at: :desc))
  end

  def about
  end

  def term
  end
end
