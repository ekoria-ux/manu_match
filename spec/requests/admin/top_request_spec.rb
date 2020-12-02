require 'rails_helper'

RSpec.describe "Admin::Tops", type: :request do
  let(:admin_user) { create(:admin_user) }
  let(:user) { create(:user) }

  before { login_user(admin_user) }

  describe "GET /index" do
    it "成功のレスポンスを返すこと" do
      get admin_root_path
      expect(response).to have_http_status(:success)
    end

    it "admin以外はhome画面にリダイレクトされること" do
      login_user(user)
      get admin_root_path
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end
  end
end
