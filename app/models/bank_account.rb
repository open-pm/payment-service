# frozen_string_literal: true
# This class represents a Recipient's bank account. Here there are all information needed
# to send money to a customer Owner.
class BankAccount < ApplicationRecord
  belongs_to :recipient
  validates_presence_of :bank_code, :account_number, :account_digit, :branch_number,
                        :branch_digit
  validates_uniqueness_of :bank_code, scope: %i[branch_number branch_digit account_number
                                                account_digit recipient_id],
                                      case_sensitive: false
end
