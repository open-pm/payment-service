# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  it { should belong_to(:recipient) }

  it { should validate_presence_of(:account_number) }
  it { should validate_presence_of(:account_digit) }
  it { should validate_presence_of(:branch_number) }
  it { should validate_presence_of(:branch_digit) }
  it { should validate_presence_of(:bank_code) }

  it do
    should validate_uniqueness_of(:bank_code).case_insensitive
                                             .scoped_to(:branch_number, :branch_digit,
                                                        :account_number, :account_digit,
                                                        :recipient_id)
  end
end
