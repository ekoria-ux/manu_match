FactoryBot.define do
  factory :comment do
    content { "Lorem ipsum" }
    association :article
    association :user
  end
end
