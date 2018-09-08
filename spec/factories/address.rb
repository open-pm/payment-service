FactoryBot.define do
  factory :address do
    street { "MyString" }
    number { 1 }
    zip_code { "MyString" }
    complement { "MyString" }
    owner { nil }
  end
end
