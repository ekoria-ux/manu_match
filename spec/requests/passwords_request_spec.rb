require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  let(:user) { create(:user) }

  before { login_user(user) }

  describe "GET /edit" do
    it "成功のレスポンスを返すこと" do
      get edit_password_path
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH /update" do
    it "update成功時はアカウントページにリダイレクトされること" do
      patch password_path, params: {
        account: {
          current_password: "secret",
          password: "password",
          password_confirmation: "password",
        },
      }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(account_path)
    end
  end
end
