FactoryBot.define do
  factory :comment do
    user_id { 1 }
    article_id { 1 }
    content { "Lorem ipsum" }
    association :article
  end
end
