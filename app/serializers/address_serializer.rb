# frozen_string_literal: true

# Serializer method for Address model
class AddressSerializer < ActiveModel::Serializer
  attributes :street, :number, :zip_code
end
