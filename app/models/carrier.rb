class Carrier < ApplicationRecord
	default_scope { order(:created_at) }
	validates :name, :rfc, :phone, :country, :state, :address, :cp, presence: true
end
