module LoginModule
  def login(user)
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: "secret"
    click_button "ログイン"
  end
end
