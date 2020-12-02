require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:favorite) { create(:favorite) }
  let(:article) { favorite.article }

  describe "POST /create" do
    it "成功レスポンスを返すこと" do
      post article_favorites_path(article), xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /destroy" do
    it "成功レスポンスを返すこと" do
      delete article_favorites_path(article), xhr: true
      expect(response).to have_http_status(:success)
    end
  end
end
