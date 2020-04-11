class Municipality < ApplicationRecord
	belongs_to :state, inverse_of: :municipalities
	has_many :localities, primary_key: :id, foreign_key: :municipality_id, 
		class_name: "Location" 
  has_many :delivery_addresses, inverse_of: :municipality

end
