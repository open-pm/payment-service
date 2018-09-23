# frozen_string_literal: true

# Serializer Class for Document model
class DocumentSerializer < ActiveModel::Serializer
  attributes :document_type, :number
end
