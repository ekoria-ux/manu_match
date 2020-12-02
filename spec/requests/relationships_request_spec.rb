require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe "POST /create" do
    it "ログインしていないとcreateできないこと" do
      post relationships_path
      expect { Relationship.create }.to change(Relationship, :count).by(0)
    end
  end
end
