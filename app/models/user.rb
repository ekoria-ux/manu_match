class User < ApplicationRecord
  authenticates_with_sorcery!
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :name, presence: true,
                   length: { maximum: 20, message: "20文字以下にしてください" }
  validates :email, presence: true,
                    length: { maximum: 100, message: "100文字以下にしてください" },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true,
                       length: { minimum: 6, message: "6文字以上にしてください" },
                       if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true,
                       if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true,
                                    if: -> { new_record? || changes[:crypted_password] }
end
