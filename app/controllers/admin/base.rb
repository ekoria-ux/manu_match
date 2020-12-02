class Admin::Base < ApplicationController
  before_action :admin_login_required

  private

  def admin_login_required
    redirect_to(root_url) unless current_user&.administrator?
  end
end
