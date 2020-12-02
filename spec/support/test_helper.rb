module TestHelper
  include Sorcery::TestHelpers::Rails::Integration

  def login_user(user)
    post login_path, params: { email: user.email, password: 'secret' }
    follow_redirect!
  end
end
