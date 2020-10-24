class Article < ApplicationRecord
  belongs_to :user
  validates :title, :date_hired_from, :date_hired_to, :body, presence: true
  validates :title, length: { maximum: 200 }
  validates :body, length: { maximum: 2000 }
  validates :skill, :remark, length: { maximum: 1000 }
end
