# frozen_string_literal: true

FactoryBot.define do
  factory :contact_info do
    document_type { '' }
    info { 'MyString' }
    owner { nil }
  end
end
