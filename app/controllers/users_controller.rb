class UsersController < ApplicationController
  include Pagy::Backend
  before_action :require_login, except: [:new, :create]
  after_action :default_image, only: :create

  def show
    @user = User.find(params[:id])
    @pagy, @articles = pagy(@user.articles.visible.order(created_at: :desc))
  end

  def new
    @user = User.new
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

  private

  def user_params
    attrs = [
      :name, :company_name, :avatar, :email, :phone_number,
      :website, :remember,
    ]
    attrs << [:password, :password_confirmation] if params[:action] == "create"
    params.require(:user).permit(attrs)
  end

  def default_image
    unless @user.avatar.attached?
      @user.avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default-image.png'
          )
        ),
        filename: 'default-image.png', content_type: 'image/png'
      )
    end
  end
end
