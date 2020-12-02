class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
  end

  def create
    user = login(
      params[:email], params[:password], params[:remember]
    )
    if user.present? && user.administrator?
      redirect_to admin_root_path, flash: { success: "おかえりなさい" }
    elsif user.present?
      params[:remember] == '1' ? remember_me! : force_forget_me!
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
