require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it "成功のレスポンスを返すこと" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end
