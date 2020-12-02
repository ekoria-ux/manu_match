require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:admin_user) { create(:admin_user) }
  let(:user) { create(:user) }

  before { login_user(admin_user) }

  describe "GET /index" do
    it "成功のレスポンスが返ること" do
      get admin_users_path
      expect(response).to have_http_status(:success)
    end

    it "adminでなければhome画面にリダイレクトされること" do
      login_user(user)
      get admin_users_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /new" do
    it "成功のレスポンスが返ること" do
      get new_admin_user_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "新規ユーザー登録後はユーザー管理ページにリダイレクトされること" do
      expect do
        post admin_users_path, params: {
          user: {
            name: "太郎",
            company_name: "株式会社taro",
            email: "taroro@example.com",
            password: "password",
            password_confirmation: "password",
          },
        }
      end.to change(User, :count).by(1)
      expect(response).to redirect_to(admin_users_path)
    end
  end

  describe "GET /edit" do
    it "成功のレスポンスが返ること" do
      get edit_admin_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "update成功時はユーザーページにリダイレクトされること" do
      patch admin_user_path(user), params: { user: { name: "太郎" } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(admin_user_path)
    end
  end

  describe "DELETE /destroy" do
    it "ユーザーを削除できること" do
      user = create(:user)
      expect do
        delete admin_user_path(user)
      end.to change(User, :count).by(-1)
      expect(response).to redirect_to(admin_users_path)
    end
  end
end
