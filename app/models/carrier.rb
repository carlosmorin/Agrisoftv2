class Carrier < ApplicationRecord
	default_scope { order(:id) }
	validates :name, :rfc, :phone, :country_id, :state_id, :address, :cp,
		:municipality_id, presence: true
	has_many :drivers, inverse_of: :carrier
	has_many :units, inverse_of: :carrier
	has_many :boxes, inverse_of: :carrier
	has_many :freights, inverse_of: :carrier
	has_many :shipments, inverse_of: :carrier
	belongs_to :country
	belongs_to :state
	belongs_to :municipality
	validates_uniqueness_of :rfc, case_sensitive: false

	def short_address
		state_name = state.name
		mun = municipality.name
		"#{state_name}, #{mun}, #{address}"
	end

	def full_address
		"#{municipality.name}, #{state.name}, #{address}, #{country.name}"
	end

end