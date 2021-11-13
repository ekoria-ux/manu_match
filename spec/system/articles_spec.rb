require 'rails_helper'

RSpec.describe "Articles", type: :system do
  let!(:user) { create(:user) }

  describe "記事の登録" do
    it "記事が投稿できること" do
      login(user)
      visit root_path
      click_link "新規投稿"
      fill_in "article_title", with: "This id test article"
      fill_in "article_body", with: "test test test"
      select Date.current.next_year.year, from: "article_date_hired_to_1i"
      fill_in "article_e_count", with: 1
      select Date.current.next_year.year, from: "article_expired_at_1i"
      select "公開", from: "article_status"
      click_on "登録"
      expect(page).to have_content("記事を登録しました")
    end
  end

  describe "記事のテスト" do
    let(:article) { create(:article) }
    let(:user) { article.author }
    let(:other_user) { create(:user, :with_avatar) }
    let(:article_with_comment) { create(:article, :with_comments) }
    let(:articles) { create_list(:article, 5) }

    before do
      login(user)
      visit article_path(article)
    end

    it "記事が編集できること" do
      click_link "編集"
      fill_in "article_body", with: "test test"
      click_on "編集"
      expect(page).to have_content("記事を更新しました")
      expect(article.reload.body).to eq "test test"
    end

    it "記事の詳細に戻るリンクのテスト" do
      click_link "編集"
      click_on "戻る"
      expect(current_path).to eq article_path(article)
    end

    it "記事が削除できること" do
      click_link "削除"
      expect(page).to have_content("記事を削除しました")
    end

    it "記事の筆者しか編集、削除はできないこと" do
      login(other_user)
      visit article_path(article)
      expect(page).not_to have_content("編集")
      expect(page).not_to have_content("削除")
    end

    it "記事にコメント、コメント削除できること" do
      login(other_user)
      visit article_path(article)
      fill_in "comment-content", with: "コメントします"
      click_on "コメントする"
      expect(page).to have_content("コメントします")
      expect(other_user.active_notifications.count).to eq 1

      click_link "コメント削除"
      expect(page).not_to have_content("コメントします")
    end

    it "コメント者しかコメント削除できないこと" do
      login(other_user)
      visit article_path(article_with_comment)
      expect(page).to have_content("Lorem ipsum")
      expect(page).not_to have_content("コメント削除")
    end

    it "記事を気になる登録、解除ができること" do
      login(other_user)
      visit article_path(article)
      click_on "気になるに登録"
      expect(article.favorites.count).to eq 1
      expect(other_user.active_notifications.count).to eq 1

      click_on "気になるを解除"
      expect(article.favorites.count).to eq 0
    end

    it "記事の筆者は気になる登録のボタンが表示されないこと" do
      visit article_path(article)
      expect(page).not_to have_content("気になるに登録")
    end

    it "同じ記事を何度も気になる登録できないこと" do
      login(other_user)
      visit article_path(article)
      click_on "気になるに登録"
      expect(page).not_to have_content("気になるに登録")
    end

    it "ユーザーが削除されたら投稿した記事が消えること" do
      expect { user.destroy }.to change(Article, :count).by(-1)
    end
  end
end
