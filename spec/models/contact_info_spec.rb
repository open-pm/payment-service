# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactInfo, type: :model do
  it { should belong_to(:owner) }

  it { should validate_presence_of(:contact_type) }
  it { should validate_presence_of(:info) }
end
