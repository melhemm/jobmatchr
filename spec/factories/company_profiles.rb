FactoryBot.define do
  factory :company_profile do
    name { "MyString" }
    address { "MyString" }
    website { "MyString" }
    description { "MyText" }
    user { nil }
  end
end
