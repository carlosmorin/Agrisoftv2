class Municipality < ApplicationRecord
	belongs_to :state, inverse_of: :municipalities
	has_many :localities
	has_many :localities, primary_key: :id, foreign_key: :municipality_id, 
		class_name: "Location" 
end
