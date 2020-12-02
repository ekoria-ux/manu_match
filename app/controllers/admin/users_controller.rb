class Admin::UsersController < Admin::Base
  include Pagy::Backend
  before_action :require_login, except: [:new, :create]
  after_action :default_image, only: :create

  def index
    @pagy, @users = pagy(User.all.order(id: :desc))
    if params[:search]
      @pagy, @users = pagy(User.search(params[:search]).order(id: :desc))
    end
  end

  def show
    @user = User.find(params[:id])
    @pagy, @articles = pagy(@user.articles.order(created_at: :desc))
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
      redirect_to :admin_users, flash: { success: "ユーザー登録しました" }
    else
      flash.now[:danger] = "登録に失敗しました"
      render "new"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to [:admin, @user], flash: { success: "ユーザー情報を更新しました" }
    else
      flash.now[:danger] = "更新に失敗しました"
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to :admin_users, flash: { success: "ユーザーを削除しました" }
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
