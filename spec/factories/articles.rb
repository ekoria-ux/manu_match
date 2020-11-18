FactoryBot.define do
  factory :article do
    title { "example title" }
    body { "Lorem ipsum" }
    date_hired_from { 1.weeks.ago }
    date_hired_to { 3.weeks.from_now }
    expired_at { 3.weeks.from_now }
    e_count { 1 }
    status { "public" }
    association :author, factory: :user
  end
end
