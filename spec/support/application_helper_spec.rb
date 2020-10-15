require 'rails_helper'

describe "ApplicationHelper" do
  include ApplicationHelper

  describe "full_title" do
    it "タイトルにページタイトルとベースタイトルが含まれること" do
      expect(full_title(page_title: "foobar")).to eq "foobar - #{BASE_TITLE}"
    end

    it "ページタイトルがない場合はベースタイトルのみであること" do
      expect(full_title(page_title: "")).to eq BASE_TITLE
    end

    it "ページタイトルにnilが入ってもエラーにならないこと" do
      expect(full_title(page_title: nil)).to eq BASE_TITLE
    end
  end
end
