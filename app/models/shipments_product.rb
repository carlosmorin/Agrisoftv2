class ShipmentsProduct < ApplicationRecord
  belongs_to :shipment, optional: true
  belongs_to :product
  validates :product_id, :quantity, :price, presence: true, if: -> { shipment.order_sale? && shipment.quotation? }
	belongs_to :productable, polymorphic: true, optional: true
  
  enum unit_meassure: { lbs: 0, kg: 1, granel: 2, bulto: 3, caja: 4 }
  has_many :shipments_product_reports, inverse_of: :shipments_product, dependent: :destroy
	accepts_nested_attributes_for :shipments_product_reports, allow_destroy: true

	def quantity_reported
		return 0 if shipments_product_reports.empty?
		quantity = 0
		shipments_product_reports.each do |spr|
			spr_quantity = spr.quantity.nil? ? 0 : spr.quantity
			quantity += spr_quantity 
		end
		quantity
	end

	def for_reporting
		self.quantity - quantity_reported 
	end

	def product_name
		return "" unless self.product.present?
		self.product.name
	end


	def sale_price
		return build_price if price.zero? && shipments_product_reports.any?
		return 0 if price.nil?
		return price unless shipments_product_reports.any?
	end

	def build_price
		total_price = 0
		self.shipments_product_reports.each do |report|
			quantity = report.quantity.nil? ? 0 : report.quantity
			price = report.price.nil? ? 0 : report.price
			total_price += quantity * price
		end
		return 0 if total_price.zero?
		total_price / quantity
	end

	def total
		sale_price * quantity
	end

end