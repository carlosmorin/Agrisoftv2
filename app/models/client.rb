class Client < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, :rfc, :cp, :address, :code, presence: true
  validates :country_id, :state_id, :municipality_id, :phone, :address, presence: true
  has_many :delivery_addresses, inverse_of: :client
	belongs_to :country
	belongs_to :state
	belongs_to :municipality
	has_many :client_brands, inverse_of: :client
	has_many :shipments, inverse_of: :client
	has_many :freights, as: :debtable, inverse_of: :client
	has_many :contracts, inverse_of: :client

	validates_uniqueness_of :phone, :code, case_sensitive: false
	has_many :contacts, as: :contactable

	def full_address
		"#{address}, #{municipality.name}, #{state.name}, #{country.name}"
	end
end