require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  context "名前のvalidation" do
    it { is_expected.to validate_presence_of :name }
    it {
      is_expected.to validate_length_of(:name).
        is_at_most(20).
        with_message("20文字以下にしてください")
    }
  end

  context "emailのvalidation" do
    it { is_expected.to validate_presence_of :email }
    it {
      is_expected.to validate_length_of(:email).
        is_at_most(100).
        with_message("100文字以下にしてください")
    }
    it { is_expected.to validate_uniqueness_of :email }
  end

  context "passwordのvalidation" do
    it { is_expected.to validate_presence_of :password }
    it {
      is_expected.to validate_length_of(:password).
        is_at_least(6).
        with_message("6文字以上にしてください")
    }
  end

  context "email addressの有効性を検証" do
    it "無効なaddressの場合 除外されること" do
      invalid_addresses = %w(
        user@example,com user_at_foo.org user.name@example.
        foo@bar_baz.com foo@bar+baz.com foo@bar..com
      )
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end

    it "大文字小文字が混ざっている場合 小文字で保存されること" do
      mixed_case_email = "UseR_FOO@bAr.Com"
      user.email = mixed_case_email
      expect(user.reload.email).to eq user.email.downcase
    end
  end
end
