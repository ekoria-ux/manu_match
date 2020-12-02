require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "ユーザー登録" do
    it "ユーザー登録できること" do
      visit root_path
      click_on "ユーザー登録"
      fill_in "user[name]", with: "example_user"
      fill_in "user[company_name]", with: "example_company"
      fill_in "user[email]", with: "exex@example.com"
      fill_in "user[password]", with: "foobar"
      fill_in "user[password_confirmation]", with: "foobar"
      click_button "登録"
      expect(page).to have_content("ユーザー登録しました")
      expect(page).to have_content("アカウント情報編集")
    end
  end

  describe "ユーザー編集（アカウント編集）" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    before do
      login(user)
      click_on "アカウント情報編集"
    end

    it "アカウント編集ができること" do
      fill_in "account_name", with: "レオナルド"
      click_on "変更"
      expect(page).to have_content("アカウント情報を更新しました")
      expect(user.reload.name).to eq "レオナルド"
    end

    it "本人だけアカウント情報を編集できること" do
      login(other_user)
      visit user_path(user)
      expect(page).not_to have_content("アカウント情報編集")
    end

    it "マイページに戻るリンクのテスト" do
      click_link "マイページに戻る"
      expect(current_path).to eq account_path
    end

    it "パスワードの変更ができること" do
      click_link "パスワード変更"
      fill_in "account_current_password", with: "secret"
      fill_in "account_password", with: "password"
      fill_in "account_password_confirmation", with: "password"
      click_on "変更"
      expect(page).to have_content("パスワードを変更しました")
    end

    it "現在のパスワードが入力されていないと変更できないこと" do
      click_link "パスワード変更"
      fill_in "account_password", with: "password"
      fill_in "account_password_confirmation", with: "password"
      click_on "変更"
      expect(page).to have_content("現在のパスワードを入力してください")
    end

    it "パスワードとパスワード確認が異なると変更できないこと" do
      click_link "パスワード変更"
      fill_in "account_current_password", with: "secret"
      fill_in "account_password", with: "password"
      fill_in "account_password_confirmation", with: "pass"
      click_on "変更"
      expect(page).to have_content("変更に失敗しました")
    end

    it "アカウント情報編集に戻るリンクのテスト" do
      click_link "パスワード変更"
      click_link "アカウント情報編集に戻る"
      expect(current_path).to eq edit_account_path
    end
  end

  describe "フォロー" do
    let!(:user) { create(:user) }
    let(:other_user) { create(:user) }

    before do
      login(user)
      visit user_path(other_user)
    end

    it "フォローとフォロー解除" do
      click_on "フォローする"
      expect(user.following.count).to eq 1
      expect(other_user.followers.count).to eq 1
      expect(other_user.passive_notifications.count).to eq 1

      click_on "フォロー解除"
      expect(user.following.count).to eq 0
      expect(other_user.followers.count).to eq 0
    end

    it "同じ人を何度もフォローできないこと" do
      click_on "フォローする"
      expect(page).not_to have_content("フォローする")
    end
  end
end
