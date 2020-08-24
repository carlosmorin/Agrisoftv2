class Carrier < ApplicationRecord
	default_scope { order(:id) }
	validates :name, :phone, :country_id, :state_id, :municipality_id, presence: true
	has_many :drivers, inverse_of: :carrier
	has_many :units, inverse_of: :carrier
	has_many :boxes, inverse_of: :carrier
	has_many :freights, inverse_of: :carrier
	has_many :shipments, inverse_of: :carrier
	has_many :contacts, as: :contactable
	belongs_to :country
	belongs_to :state
	belongs_to :municipality
	
	has_many :bank_accounts, as: :accountable
	has_many :fiscals, as: :fiscalable
	accepts_nested_attributes_for :fiscals, allow_destroy: true

	def short_address
		state_name = state.name
		mun = municipality.name
		"#{state_name}, #{mun}, #{address}"
	end

	def full_address
		"#{municipality.name}, #{state.name}, #{address}, #{country.name}"
	end

	def full_name
		"#{name}, RFC: #{ rfc }"
	end

end