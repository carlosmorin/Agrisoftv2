class Location < ApplicationRecord
	self.table_name = "localities"
	belongs_to :municipality
end
