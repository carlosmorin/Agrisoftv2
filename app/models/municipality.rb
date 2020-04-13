class Municipality < ApplicationRecord
	belongs_to :state, inverse_of: :municipalities
	has_many :locations, primary_key: :id, foreign_key: :municipality_id, 
		class_name: "Location" 
  has_many :delivery_addresses, inverse_of: :municipality
  has_many :clients, inverse_of: :municipality
  has_many :carriers, inverse_of: :municipality

end
