require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:comment) { create(:comment) }
  let(:article) { comment.article }

  describe "GET /create" do
    it "成功レスポンスを返すこと" do
      post article_comments_path(article), xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "成功レスポンスを返すこと" do
      delete article_comment_path(article, comment.id), xhr: true
      expect(response).to have_http_status(:success)
    end
  end
end
