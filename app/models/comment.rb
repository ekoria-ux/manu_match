class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_many :notifications, dependent: :destroy
  validates :content, presence: true, length: { maximum: 500 }
end
