class Address < ApplicationRecord
  belongs_to :owner

  validates_presence_of :street, :number, :zip_code
end
