require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:user) { create(:user) }

  before { login_user(user) }

  describe "GET /index" do
    it "成功レスポンスを返すこと" do
      get notifications_path
      expect(response).to have_http_status(:success)
    end
  end
end
