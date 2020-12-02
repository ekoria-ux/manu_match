require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  it "ログイン、ログアウトするができること" do
    user = create(:user)

    visit root_path
    click_link "ログイン"
    fill_in "email", with: user.email
    fill_in "password", with: "secret"
    click_button "ログイン"
    expect(page).to have_content "ログインしました"

    click_link "ログアウト"
    expect(page).to have_content "ログアウトしました"
  end

  it "登録されているユーザーしかログインできないこと" do
    user = build(:user)
    login(user)
    expect(page).to have_content("ログインに失敗しました")
  end
end
