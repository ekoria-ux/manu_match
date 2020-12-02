FactoryBot.define do
  factory :relationship do
    association :followed, factory: :user
    association :follower, factory: :admin_user
  end
end
