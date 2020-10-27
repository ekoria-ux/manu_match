class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(params[:user][:email], params[:user][:password])
      redirect_to @user, flash: { success: "ユーザー登録しました" }
    else
      flash.now[:danger] = "登録に失敗しました"
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, flash: { success: "ユーザー情報を更新しました" }
    else
      flash.now[:danger] = "更新に失敗しました"
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :user, flash: { success: "ユーザーを削除しました" }
  end

  private

  def user_params
    params.require(:user).permit(:name, :company_name, :avatar, :email, :phone_number,
                                 :website, :password, :password_confirmation, :remember_me)
  end
end
