FactoryBot.define do
  factory :user do
    name { "example user" }
    company_name { "exmple company" }
    sequence(:email) { |n| "tester#{n}@examle.com" }
    password { "passwordfoobar" }
    password_confirmation { "passwordfoobar" }
  end
end
