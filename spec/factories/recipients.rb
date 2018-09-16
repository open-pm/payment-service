# frozen_string_literal: true

# frozen_string_litreal: true

FactoryBot.define do
  factory :recipient do
    remote_id { Faker::Internet.password(10) }
    owner { FactoryBot.build(:owner) }
  end
end
