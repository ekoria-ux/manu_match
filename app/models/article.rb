class Article < ApplicationRecord
  belongs_to :user
  validates :title, :date_hired_from, :date_hired_to, :body, presence: true
  validates :title, length: { maximum: 200 }
  validates :body, length: { maximum: 2000 }
  validates :skill, :remark, length: { maximum: 1000 }
  validates :e_count, numericality: { less_than_or_equal_to: 100 }
  validate :check_date

  def check_date
    errors.add(:date_hired_to, "の日付を正しく入力して下さい") unless date_hired_from <= date_hired_to
  end
end
