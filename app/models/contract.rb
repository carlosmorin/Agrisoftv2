class Contract < ApplicationRecord
  belongs_to :client
  belongs_to :delivery_address
  has_many :contracts_products, inverse_of: :contract, dependent: :destroy

	accepts_nested_attributes_for :contracts_products, allow_destroy: true
	
	validates_presence_of :name, :delivery_address_id
	validates_presence_of :started_at, :finished_at, unless: :undefined

	def active?
		return true if self.undefined?
		
		Time.now <= self.finished_at 
	end

	def currency
		national = Currency.national.first
		return national if self.contracts_products.empty?
		self.contracts_products.first.currency
	end
end
