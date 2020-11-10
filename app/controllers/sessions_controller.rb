class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    user = login(
      params[:session][:email], params[:session][:password], params[:session][:remember_me]
    )
    if user.present?
      params[:session][:remember_me] == '1' ? remember_me! : force_forget_me!
      redirect_back_or_to :account, success: "ログインしました"
    else
      flash.now[:danger] = "ログインに失敗しました"
      render "new"
    end
  end

  def destroy
    forget_me!
    logout
    redirect_to root_path, flash: { success: "ログアウトしました" }
  end
end