require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  let(:user) { create(:user) }

  before { login_user(user) }

  describe "GET /show" do
    it "成功のレスポンスが返ること" do
      get account_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /edit" do
    it "成功のレスポンスが返ること" do
      get edit_account_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /update" do
    it "update成功時はアカウントページにリダイレクトされること" do
      patch account_path(user), params: { account: { name: "太郎" } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(account_path)
    end
  end
end
