# frozen_string_literal: true

# This class represents a recipient Owner. It aggregates some
# information necessary to reffer a recipient owner and could be used to
# validate some information from external resources.
class Owner < ApplicationRecord
  has_many :contact_infos, dependent: :destroy
  has_one :document, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :recipient, dependent: :destroy

  validates_presence_of :legal_name
  accepts_nested_attributes_for :contact_infos, :document, :address
end
