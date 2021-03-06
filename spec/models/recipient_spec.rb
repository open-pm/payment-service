# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipient, type: :model do
  it { should belong_to(:owner) }
  it { should have_one(:bank_account) }
end
