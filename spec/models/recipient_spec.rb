# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipient, type: :model do
  it { should belong_to(:owner) }

  it { should validate_presence_of(:remote_id) }
  it { should validate_presence_of(:provider_name) }
end
