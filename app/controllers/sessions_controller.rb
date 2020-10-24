class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:session][:email], params[:session][:password])
    if user.present?
      redirect_to root_path, notice: "ログインしました"
    else
      redirect_to login_path, alert: "ログインに失敗しました"
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: "ログアウトしました"
  end
end
