class Carrier < ApplicationRecord
	default_scope { order(:id) }
	validates :name, :rfc, :phone, :country, :state, :address, :cp,
		:municipality, presence: true
	has_many :drivers, inverse_of: :carrier
	has_many :units, inverse_of: :carrier
	has_many :boxes, inverse_of: :carrier

end