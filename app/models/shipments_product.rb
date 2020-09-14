class ShipmentsProduct < ApplicationRecord
  belongs_to :shipment, optional: true
  belongs_to :product
  validates :product_id, :quantity, :price, presence: true, if: -> { shipment.order_sale? && shipment.quotation? }
	belongs_to :productable, polymorphic: true, optional: true
  
  enum unit_meassure: { lbs: 0, kg: 1, granel: 2, bulto: 3, caja: 4 }
end