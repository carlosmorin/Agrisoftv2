class Client < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, :rfc, :cp, :address, presence: true
  validates :country_id, :state_id, :municipality_id, :phone, :address, presence: true
  has_many :delivery_addresses, inverse_of: :client
	belongs_to :country
	belongs_to :state
	belongs_to :municipality

	validates_uniqueness_of :phone, :email, case_sensitive: false
end