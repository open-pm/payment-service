class Owner < ApplicationRecord
  has_many :contact_infos, dependent: :destroy
  has_one :document, dependent: :destroy
  has_one :address, dependent: :destroy

  validates_presence_of :legal_name
end
