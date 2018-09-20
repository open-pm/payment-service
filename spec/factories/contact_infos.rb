# frozen_string_literal: true

FactoryBot.define do
  factory :contact_info do
    contact_type { %w(email, cel, land_number).sample }
    info { 'MyString' }
  end
end
