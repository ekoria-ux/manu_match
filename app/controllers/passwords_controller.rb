class PasswordsController < ApplicationController
  before_action :require_login
  def show
    redirect_to :account
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    current_password = params[:account][:current_password]
    if current_password.present? && params[:account][:password].present? && @user.valid_password?(current_password)
      if @user.update(password_params)
        redirect_to :account, flash: { success: "パスワードを変更しました" }
      else
        flash.now[:danger] = "変更に失敗しました"
        render "edit"
      end
    elsif current_password.blank?
      @user.errors.add(:current_password, :empty)
      render "edit"
    elsif params[:account][:password].blank?
      @user.errors.add(:password, :empty)
      render "edit"
    else
      @user.errors.add(:current_password, :wrong)
      render "edit"
    end
  end

  private

  def password_params
    params.require(:account).permit(:password, :password_confirmation)
  end
end
