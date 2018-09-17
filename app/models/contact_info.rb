# frozen_string_literal: true

# This class represents a contact Inormation which
# belongs to a recipient owner
class ContactInfo < ApplicationRecord
  belongs_to :owner

  validates_presence_of :contact_type, :info
end
