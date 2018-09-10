# frozen_string_literal: true

# This class represents an Address which belongs to
# a recipient Owner
class Address < ApplicationRecord
  belongs_to :owner

  validates_presence_of :street, :number, :zip_code
end
