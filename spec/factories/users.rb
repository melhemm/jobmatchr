FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    role { :employee }

    trait :company do
      role { :company }
    end
    trait :employee do
      role { :employee }
    end
  end
end
