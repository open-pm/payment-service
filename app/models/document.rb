# frozen_string_literal: true

# This class represents a Document wich belongs to
# a recipient owner and will be used for some external
# validations
class Document < ApplicationRecord
  belongs_to :owner
  validates_presence_of :document_type, :number
end
