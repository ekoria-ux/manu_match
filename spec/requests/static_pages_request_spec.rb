require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /home" do
    it "成功のレスポンスが返ること" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "成功のレスポンスが返ること" do
      get about_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /term" do
    it "成功のレスポンスが返ること" do
      get term_path
      expect(response).to have_http_status(:success)
    end
  end
end
