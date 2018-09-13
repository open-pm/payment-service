# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Owner, type: :model do
  it { should have_many(:contact_infos) }
  it { should have_one(:document) }
  it { should have_one(:address) }
  it { should have_many(:recipient) }

  it { should validate_presence_of(:legal_name) }
end
