class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :articles, dependent: :destroy
  has_one_attached :avatar
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :name, presence: true,
                   length: { maximum: 20 }
  validates :company_name, presence: true,
                           length: { maximum: 100 }
  validates :email, presence: true,
                    length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true,
                       length: { minimum: 6 },
                       if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true,
                       if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true,
                                    if: -> { new_record? || changes[:crypted_password] }
  validates :avatar, content_type: { in: %w(image/jpeg image/png), message: "jpeg、pngが使用可能です" },
                     size: { less_than: 5.megabytes, message: "5MB以下のファイルにしてください" }

  class << self
    def search(query)
      rel = order("id")
      if query.present?
        rel = rel.where("company_name LIKE ?", "%#{query}%")
      end
      rel
    end
  end

  def profile_avatar
    avatar.variant(resize_to_fill: [150, 150])
  end
end
