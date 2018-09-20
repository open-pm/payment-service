# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street { Faker::Address.street_name }
    number { Faker::Address.building_number }
    zip_code { Faker::Address.zip_code }
    complement { [nil, "", Faker::Address.secondary_address].sample  }
  end
end
