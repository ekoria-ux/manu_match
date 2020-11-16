module ApplicationHelper
  include Pagy::Frontend
  
  def full_title(page_title:)
    if page_title.blank?
      BASE_TITLE
    else
      "#{page_title} - #{BASE_TITLE}"
    end
  end

  def unchecked_notifications
    @notifications=current_user.passive_notifications.where(checked: false)
  end
end
