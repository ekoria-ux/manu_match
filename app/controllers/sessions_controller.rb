class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:session][:email], params[:session][:password], params[:session][:remember_me])
    params[:session][:remember_me] == '1' ? remember_me! : force_forget_me!
    if user.present?
      redirect_to root_path, notice: "ログインしました"
    else
      redirect_to login_path, alert: "ログインに失敗しました"
    end
  end

  def destroy
    remember_me!
    force_forget_me!
    logout
    redirect_to login_path, notice: "ログアウトしました"
  end
end
