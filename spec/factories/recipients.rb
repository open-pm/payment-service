# frozen_string_literal: true

# frozen_string_litreal: true

FactoryBot.define do
  factory :recipient do
    remote_id { Faker::Internet.password(10) }
    # TODO: (walteraa) randomize it by using existing providers in our system
    provider_name { Faker::Internet.username }
    owner { nil }
  end
end
