FactoryBot.define do
  factory :owner do
    legal_name { Faker::StarWars.character }
    metadata { "MyString" }
  end
end