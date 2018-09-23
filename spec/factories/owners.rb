# frozen_string_literal: true

FactoryBot.define do
  factory :owner do
    legal_name { Faker::StarWars.character }
    metadata { 'MyString' }
    document { FactoryBot.build :document }
    contact_infos { [FactoryBot.build(:contact_info)] }
    address { FactoryBot.build :address }
  end
end
