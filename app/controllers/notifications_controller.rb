class NotificationsController < ApplicationController
  include Pagy::Backend
  before_action :require_login

  def index
    @pagy, @notifications = pagy(
      current_user.passive_notifications.
      includes(:article, visitor: { avatar_attachment: :blob }).
      order(created_at: :desc)
    )
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
