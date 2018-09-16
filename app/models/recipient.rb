# frozen_string_literal: true

# This class represents a recipient, it will have any information necessary to send
# transferences to Owne and is used to map all transactions which belongs to a specific
# Onwer.
class Recipient < ApplicationRecord
  belongs_to :owner
  has_one :bank_account

  validates_presence_of :remote_id
end
