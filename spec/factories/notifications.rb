FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user
    association :visited, factory: :user
    checked { true }
  end

  trait :action_comment do
    action { "comment" }
  end

  trait :action_follow do
    action { "follow" }
  end

  trait :action_favorite do
    action { "favorite" }
  end
end
