class ContactInfo < ApplicationRecord
  belongs_to :owner

  validates_presence_of :type, :info
end
