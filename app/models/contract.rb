class Contract < ApplicationRecord
  belongs_to :client
  belongs_to :delivery_address
  has_many :contracts_products, inverse_of: :contract, dependent: :destroy

	accepts_nested_attributes_for :contracts_products, allow_destroy: true
	
	validates_presence_of :name, :started_at, :finished_at, :delivery_address_id
end
