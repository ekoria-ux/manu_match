class ApplicationController < ActionController::Base
  private

  def not_authenticated
    redirect_to login_path, flash: { danger: "ログインしてください" }
  end
end
