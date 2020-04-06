class Carrier < ApplicationRecord
	default_scope { order(:id) }
	validates :name, :rfc, :phone, :country, :state, :address, :cp,
		:municipality, presence: true
	has_many :drivers, inverse_of: :carrier
end