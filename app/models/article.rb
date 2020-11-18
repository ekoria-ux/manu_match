class Article < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  validates :title, :date_hired_from, :date_hired_to, :body, presence: true
  validates :title, length: { maximum: 200 }
  validates :body, length: { maximum: 2000 }
  validates :skill, :remark, length: { maximum: 1000 }
  validates :e_count, numericality: { less_than_or_equal_to: 100 }
  validates :status, inclusion: { in: STATUS_VALUES }
  validate :check_date

  scope :visible, -> { where("expired_at > ?", Time.current) }
  scope :published, -> { where("status <> ?", "draft") }

  def check_date
    errors.add(:date_hired_to, :hired_to_old) unless date_hired_from <= date_hired_to
  end

  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.article.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status] }
    end

    def search(search)
      if search
        Article.where(
          [
            "title LIKE ? OR body LIKE ? OR area LIKE ? OR skill LIKE ? OR category LIKE ?",
            "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%",
          ]
        )
      else
        Article.all
      end
    end
  end

  def favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_favorite(current_user)
    temp = Notification.where(
      [
        "visitor_id = ? and visited_id = ? and article_id = ? and action = ? ",
        current_user.id, user_id, id, "favorite",
      ]
    )
    if temp.blank?
      notification = current_user.active_notifications.new(
        article_id: id,
        visited_id: user_id,
        action: "favorite"
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(article_id: id).where.not(
      user_id: current_user.id
    ).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      article_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
