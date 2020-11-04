class Article < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "user_id"
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
  end
end
