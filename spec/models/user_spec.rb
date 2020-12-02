require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user, :with_avatar) }
  let(:other_user) { create(:user) }

  describe "名前のvalidation" do
    it { is_expected.to validate_presence_of :name }
    it {
      is_expected.to validate_length_of(:name).
        is_at_most(20)
    }
  end

  describe "会社名のvalidation" do
    it { is_expected.to validate_presence_of :company_name }
    it {
      is_expected.to validate_length_of(:company_name).
        is_at_most(100)
    }
  end

  describe "emailのvalidation" do
    it { is_expected.to validate_presence_of :email }
    it {
      is_expected.to validate_length_of(:email).
        is_at_most(100)
    }
    it { is_expected.to validate_uniqueness_of :email }
  end

  describe "passwordのvalidation" do
    it { is_expected.to validate_presence_of :password }
    it {
      is_expected.to validate_length_of(:password).
        is_at_least(6)
    }
  end

  describe "avatarのvalidation" do
    it "ユーザーにはavatar画像が添付されていること" do
      expect(user.avatar).to be_attached
    end

    context "容量が5MB以上のファイルの場合" do
      let(:user) { build(:user, :with_large_avatar) }

      it "有効ではないこと" do
        user.valid?
        expect(user.errors.messages[:avatar]).to include("5MB以下のファイルにしてください")
      end
    end

    context "ファイルタイプがjpeg/png以外の場合" do
      let(:user) { build(:user, :with_unpermit_type) }

      it "有効ではないこと" do
        user.valid?
        expect(user.errors.messages[:avatar]).to include("jpeg、pngが使用可能です")
      end
    end
  end

  describe "email addressの有効性を検証" do
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

  describe "searchのテスト" do
    before do
      @user1 = create(:user, name: "小造", company_name: "株式会社abc")
      @user2 = create(:user, name: "小太郎", company_name: "有限会社xyz")
      @user3 = create(:user, name: "太郎", company_name: "abc company")
    end

    context "name searchのテスト" do
      it "'小'で検索したら名前に検索文字を含まない人は結果に含まないこと" do
        expect(User.search("小")).not_to include(@user3)
      end
    end

    context "company_name searchのテスト" do
      it "'abc'で検索したら会社名前に検索文字を含まない人は結果に含まないこと" do
        expect(User.search("abc")).not_to include(@user2)
      end
    end

    context "対象が見つからない場合" do
      it "検索文字を含まない場合は空の結果を返すこと" do
        expect(User.search("合同")).to be_empty
      end
    end
  end

  describe "通知機能" do
    it "フォローされたら通知が一つ増えること" do
      expect do
        user.create_notification_follow(other_user)
      end.to change(Notification, :count).by(1)
    end
  end

  describe "関連性のテスト" do
    context "has_many" do
      it { is_expected.to have_many(:articles).dependent(:destroy) }
      it { is_expected.to have_many(:active_relationships).dependent(:destroy) }
      it { is_expected.to have_many(:passive_relationships).dependent(:destroy) }
      it { is_expected.to have_many(:comments).dependent(:destroy) }
      it { is_expected.to have_many(:favorites).dependent(:destroy) }
      it { is_expected.to have_many(:active_notifications).dependent(:destroy) }
      it { is_expected.to have_many(:passive_notifications).dependent(:destroy) }
    end
  end
end
