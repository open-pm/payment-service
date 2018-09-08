require 'rails_helper'

RSpec.describe Address, type: :model do

  # Ensure relationship
  it { should belong_to(:owner)}

  # Ensure columns are present before save
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:zip_code)}
end
