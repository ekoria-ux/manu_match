require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET /show" do
    it "リダイレクトされていること" do
      get account_path
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /edit" do
    it "リダイレクトされていること" do
      get edit_account_path
      expect(response).to have_http_status(302)
    end
  end
end
