class Shipment < ApplicationRecord
	validates :carrier_id, :driver_id, :unit_id, :box_id, presence: true
  belongs_to :carrier
  belongs_to :driver
  belongs_to :unit
  belongs_to :box
  belongs_to :user
  has_many :remissions, inverse_of: :shipment
	accepts_nested_attributes_for :remissions, allow_destroy: true
end
