# frozen_string_literal: true

# Serializer class for ContactInfo model
class ContactInfoSerializer < ActiveModel::Serializer
  attributes :contact_type, :info
end
