class AccountsController < ApplicationController
  include Pagy::Backend
  before_action :require_login
  
  def show
    @user = current_user
    @articles = @user.articles.order(created_at: :desc)
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

  def following
    @title = "フォロー中"
    @user  = current_user
    @pagy, @users = pagy(@user.following.with_attached_avatar)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = current_user
    @pagy, @users = pagy(@user.followers.with_attached_avatar)
    render 'show_follow'
  end

  private

  def account_params
    params.require(:account).permit(:name, :company_name, :avatar, :email, :phone_number,
                                    :website)
  end
end
