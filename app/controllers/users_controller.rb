class UsersController < ApplicationController
  include Pagy::Backend
  before_action :require_login, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  after_action :default_image, only: :create
  
  def show
    @user = User.find(params[:id])
    @article = @user.articles
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
      redirect_to account_path, flash: { success: "ユーザー登録しました" }
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

  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @pagy, @users = pagy(@user.following)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @pagy,@users = pagy(@user.followers)
    render 'show_follow'
  end

  private

  def user_params
    attrs = [
      :name, :company_name, :avatar, :email, :phone_number,
      :website, :remember_me,
    ]
    attrs << [:password, :password_confirmation] if params[:action] == "create"
    params.require(:user).permit(attrs)
  end

  def default_image
    unless @user.avatar.attached?
      @user.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-image.png')), filename: 'default-image.png', content_type: 'image/png')
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user == @user
  end
end
