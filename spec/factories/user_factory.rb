FactoryGirl.define do
  factory :user, class: GetSwole::User do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "123456"
  end
end
