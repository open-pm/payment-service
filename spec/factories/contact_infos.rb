# frozen_string_literal: true

FactoryBot.define do
  factory :contact_info do
    type { '' }
    info { 'MyString' }
    owner { nil }
  end
end
