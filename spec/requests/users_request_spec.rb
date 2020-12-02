require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET /show" do
    it "成功のレスポンスが返ること" do
      login_user(user)
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it "ログインしていなければログイン画面へリダイレクトされること" do
      get user_path(user)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(login_path)
    end
  end

  describe "GET /new" do
    it "成功のレスポンスが返ること" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "ユーザーが登録されたらアカウント画面へリダイレクトされること" do
      post users_path, params: {
        user: {
          name: "太郎",
          company_name: "株式会社taro",
          email: "taroro@example.com",
          password: "password",
          password_confirmation: "password",
        },
      }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(account_path)
    end
  end
end
