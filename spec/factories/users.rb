FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "example user#{n}" }
    company_name { "exmple company" }
    sequence(:email, 10000) { |n| "person#{n}@example.com" }
    password { "secret" }
    password_confirmation { "secret" }
  end

  factory :admin_user, parent: :user do
    name { "admin" }
    company_name { "manu_match company" }
    email { "manumanu@example.com" }
    password { "secret" }
    password_confirmation { "secret" }
    administrator { true }
  end

  trait :with_avatar do
    avatar do
      Rack::Test::UploadedFile.new(
        Rails.root.join(
          'app/assets/images/default-image.png',
        ), 'image/png'
      )
    end
  end

  trait :with_large_avatar do
    avatar do
      Rack::Test::UploadedFile.new(
        Rails.root.join(
          'spec/support/images/large-image.png',
        ), 'image/png'
      )
    end
  end

  trait :with_unpermit_type do
    avatar do
      Rack::Test::UploadedFile.new(
        Rails.root.join(
          'spec/support/images/image.gif',
        ), 'image/gif'
      )
    end
  end
end
