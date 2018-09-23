# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    number { Faker::IDNumber.valid }
    document_type { %w[ID Passpot CPF CNPJ].sample }
  end
end
