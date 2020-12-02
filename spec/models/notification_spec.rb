require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "visitor_idのvalidation" do
    it { is_expected.to validate_presence_of :visitor_id }
  end

  describe "visited_idのvalidation" do
    it { is_expected.to validate_presence_of :visited_id }
  end

  describe "関連性のテスト" do
    context "belongs_to" do
      it { is_expected.to belong_to(:visitor).optional(true) }
      it { is_expected.to belong_to(:visited).optional(true) }
      it { is_expected.to belong_to(:comment).optional(true) }
      it { is_expected.to belong_to(:article).optional(true) }
    end
  end
end
