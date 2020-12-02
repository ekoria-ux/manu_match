require 'rails_helper'

RSpec.describe Favorite, type: :model do
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
