FactoryBot.define do
  factory :article do
    association :author, factory: :user
    title { "example title" }
    body { "Lorem ipsum" }
    date_hired_from { 1.week.from_now }
    date_hired_to { 3.weeks.from_now }
    expired_at { 3.weeks.from_now }
    e_count { 1 }
    status { "public" }
  end

  trait :with_comments do
    after(:create) do |article|
      create_list :comment, 2
    end
  end
end
