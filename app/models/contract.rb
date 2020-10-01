class Contract < ApplicationRecord
  belongs_to :client
  belongs_to :delivery_address
  belongs_to :currency
  has_many :contracts_products, inverse_of: :contract, dependent: :destroy
  has_many :contracts_expenses, inverse_of: :contract, dependent: :destroy
  has_many :expenses, through: :contracts_expenses, dependent: :destroy
  has_many :shipments

  accepts_nested_attributes_for :contracts_products, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :contracts_expenses, reject_if: :all_blank, allow_destroy: true

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
