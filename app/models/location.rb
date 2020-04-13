class Location < ApplicationRecord
	self.table_name = "locations"
	belongs_to :municipality
  has_many :delivery_addresses, inverse_of: :location
end
