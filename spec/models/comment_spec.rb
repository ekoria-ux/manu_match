require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "contentのvalidation" do
    it { is_expected.to validate_presence_of :content }
    it {
      is_expected.to validate_length_of(:content).
        is_at_most(500)
    }
  end

  describe "関連性のテスト" do
    context "has_many" do
      it { is_expected.to have_many(:notifications).dependent(:destroy) }
    end

    context "belongs_to" do
      it { is_expected.to belong_to(:user) }
      it { is_expected.to belong_to(:article) }
    end
  end
end
