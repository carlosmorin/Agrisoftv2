class Shipment < ApplicationRecord
  belongs_to :company
  belongs_to :client
  belongs_to :delivery_address
  belongs_to :shipment
  belongs_to :user
  validates :client_id, :company_id, :delivery_address_id, presence: true

  has_many :remissions_products
  has_many :products, through: :remissions_products
  accepts_nested_attributes_for :remissions_products, allow_destroy: true
end
