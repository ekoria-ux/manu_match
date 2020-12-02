require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "follower_idのvalidation" do
    it { is_expected.to validate_presence_of :follower_id }
  end

  describe "followed_idのvalidation" do
    it { is_expected.to validate_presence_of :followed_id }
  end

  describe "関連性のテスト" do
    context "belongs_to" do
      it { is_expected.to belong_to(:follower) }
      it { is_expected.to belong_to(:followed) }
    end
  end
end
