# frozen_string_literal: true

FactoryBot.define do
  factory :bank_account do
    account_number { Faker::Bank.account_number }
    account_digit { Faker::Bank.account_number(2) }
    bank_code { Faker::Number.between(1,999) }
    branch_number { Faker::Bank.account_number(5) }
    branch_number { Faker::Bank.account_number(2) }
    recipient { FactoryBot.build(:recipient) }
  end
end
