class AddressSerializer < ActiveModel::Serializer
  attributes :street, :number, :zip_code
end
