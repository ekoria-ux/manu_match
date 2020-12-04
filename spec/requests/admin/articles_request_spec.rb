require 'rails_helper'

RSpec.describe "Admin::Articles", type: :request do
  let(:admin_user) { create(:admin_user) }
  let(:article) { create(:article) }
  let(:uer) { article.author }

  before { login_user(admin_user) }

  describe "GET /index" do
    it "成功のレスポンスが返ること" do
      get admin_articles_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it "成功のレスポンスが返ること" do
      get admin_article_path(article)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /new" do
    it "成功のレスポンスが返ること" do
      get new_admin_article_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /edit" do
    it "成功のレスポンスが返ること" do
      get edit_admin_article_path(article)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /create" do
    it "記事が作成できること" do
      expect do
        post admin_articles_path, params: {
          article: {
            title: "test",
            body: "test",
            e_count: 1,
            date_hired_from: 1.week.from_now,
            date_hired_to: 2.weeks.from_now,
            expired_at: 2.weeks.from_now,
            status: "public",
          },
        }
      end.to change(Article, :count).by(1)
    end
  end

  describe "PATCH /update" do
    it "updateできたら記事ページにリダイレクトされること" do
      patch admin_article_path(article), params: { article: { body: "update" } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(admin_article_path(article))
    end
  end

  describe "DELETE /destroy" do
    it "記事を削除できること" do
      article = create(:article)
      expect do
        delete admin_article_path(article)
      end.to change(Article, :count).by(-1)
    end
  end
end
