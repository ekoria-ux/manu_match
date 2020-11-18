class Notification < ApplicationRecord
  belongs_to :visitor, class_name: "User", foreign_key: "visitor_id", optional: true
  belongs_to :visited, class_name: "User", foreign_key: "visited_id", optional: true
  belongs_to :article, optional: true
  belongs_to :comment, optional: true
  validates :visitor_id, presence: true
  validates :visited_id, presence: true
end
