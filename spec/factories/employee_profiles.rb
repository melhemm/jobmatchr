FactoryBot.define do
  factory :employee_profile do
    first_name { "MyString" }
    last_name { "MyString" }
    address { "MyString" }
    skills { "MyText" }
    resume_url { "MyString" }
    user { nil }
  end
end
