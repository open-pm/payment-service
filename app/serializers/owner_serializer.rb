# frozen_string_literal: true

# Serializer class for Owner model
class OwnerSerializer < ActiveModel::Serializer
  attributes :id, :legal_name

  has_one :document, serializer: DocumentSerializer
  has_one :address, serializer: AddressSerializer
  has_many :contact_infos, serializer: ContactInfoSerializer
end
