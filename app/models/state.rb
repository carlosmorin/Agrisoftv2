class State < ApplicationRecord
	default_scope { order(:id) }
	self.primary_key = :id
	belongs_to :country, inverse_of: :states
	has_many :municipalities, primary_key: :id, foreign_key: :state_id, 
		class_name: "Municipality"
	validates :name, :short_name, :country_id, presence: true

end
