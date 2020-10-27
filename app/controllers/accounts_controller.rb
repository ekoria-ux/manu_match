class AccountsController < ApplicationController
  before_action :require_login
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(account_params)
      redirect_to :account, flash: { success: "アカウント情報を更新しました" }
    else
      flash.now[:danger] = "更新に失敗しました"
      render "edit"
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :company_name, :avatar, :email, :phone_number,
                                    :website)
  end
end
