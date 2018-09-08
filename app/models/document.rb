class Document < ApplicationRecord
  belongs_to :owner
  validates_presence_of :type, :number
end
