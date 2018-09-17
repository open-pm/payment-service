# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  it { should belong_to(:owner) }

  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:document_type) }
end
