
class Location < ApplicationRecord
	self.table_name = "localities"
	belongs_to :municipality
  has_many :delivery_addresses, inverse_of: :location
end
