require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:article) { create(:article) }
  let(:other_user) { create(:user) }

  describe "タイトルのvalidation" do
    it { is_expected.to validate_presence_of :title }
    it {
      is_expected.to validate_length_of(:title).
        is_at_most(200)
    }
  end

  describe "内容のvalidation" do
    it { is_expected.to validate_presence_of :body }
    it {
      is_expected.to validate_length_of(:body).
        is_at_most(2000)
    }
  end

  describe "必要技能のvalidation" do
    it {
      is_expected.to validate_length_of(:skill).
        is_at_most(1000)
    }
  end

  describe "備考のvalidation" do
    it {
      is_expected.to validate_length_of(:remark).
        is_at_most(1000)
    }
  end

  describe "人数のvalidation" do
    it {
      is_expected.to validate_numericality_of(:e_count).
        is_less_than_or_equal_to(100)
    }
  end

  describe "開始日のvalidation" do
    let(:article_invalid) { build(:article, date_hired_to: Date.current - 1) }

    it "終了日より以前の日付であること" do
      expect { article_invalid.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "掲載期限のテスト" do
    let(:article_expired) { create(:article, expired_at: 1.week.ago) }

    it "掲載期限が過ぎた記事は表示されないこと" do
      expect(Article.visible).not_to include(article_expired)
    end
  end

  describe "searchのテスト" do
    before do
      @article1 = create(
        :article, title: "急ぎ", body: "テストです", area: "関東", skill: "なし", category: "組立"
      )
      @article2 = create(
        :article, title: "至急", body: "テスト？", area: "関東", skill: "経験者", category: "検査"
      )
      @article3 = create(
        :article, title: "急ぎ", body: "テストだった", area: "関西", skill: "なし", category: "組立"
      )
      @article4 = create(
        :article, title: "募集", body: "内容です", area: "関西", skill: "経験者", category: "検査"
      )
    end

    context "title searchのテスト" do
      it "'急'で検索したらタイトルに検索文字を含まない記事は結果に含まないこと" do
        expect(Article.search("急")).not_to include(@article4)
      end
    end

    context "body searchのテスト" do
      it "'テスト'で検索したら内容に検索文字を含まない記事は結果に含まないこと" do
        expect(Article.search("テスト")).not_to include(@article4)
      end
    end

    context "area searchのテスト" do
      it "'関東'で検索したら地域に検索文字を含まない記事は結果に含まないこと" do
        expect(Article.search("関東")).not_to include(@article3, @article4)
      end
    end

    context "skill searchのテスト" do
      it "'経験者'で検索したら内容に検索文字を含まない記事は結果に含まないこと" do
        expect(Article.search("経験者")).not_to include(@article1, @article3)
      end
    end

    context "category searchのテスト" do
      it "'検査'で検索したら内容に検索文字を含まない記事は結果に含まないこと" do
        expect(Article.search("検査")).not_to include(@article1, @article3)
      end
    end

    context "対象が見つからない場合" do
      it "検索文字を含まない場合は空の結果を返すこと" do
        expect(Article.search("電気")).to be_empty
      end
    end
  end

  describe "通知機能" do
    it "記事にコメントされたら通知が一つ増えること" do
      comment = create(:comment)
      expect do
        article.create_notification_comment(other_user, comment)
      end.to change(Notification, :count).by(1)
    end

    it "記事をお気に入り登録したら通知が一つ増えること" do
      expect do
        article.create_notification_favorite(other_user)
      end.to change(Notification, :count).by(1)
    end
  end

  describe "関連性のテスト" do
    context "has_many" do
      it { is_expected.to have_many(:comments).dependent(:destroy) }
      it { is_expected.to have_many(:favorites).dependent(:destroy) }
      it { is_expected.to have_many(:notifications).dependent(:destroy) }
    end

    context "belongs_to" do
      it { is_expected.to belong_to(:author) }
    end
  end
end
