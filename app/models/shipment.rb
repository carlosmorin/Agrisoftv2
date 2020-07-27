class Shipment < ApplicationRecord
	include FolioGenerator

  default_scope { order(created_at: :desc) }

	before_create :set_products
	before_create :set_folio, if: :shipment?
	before_create :set_freight_folio, if: :shipment?
	before_create :set_client_folio, if: :shipment?

	before_update :set_folio, if: :shipment?
	before_update :set_freight_folio, if: :shipment?
	before_update :set_client_folio, if: :shipment?

	before_create :set_quote_folio, if: :quotation?

	belongs_to :company
	belongs_to :client
	belongs_to :delivery_address
	belongs_to :user
	belongs_to :freight, optional: true

	validates :client_id, :issue_at, :company_id, :user_id, :delivery_address_id, :currency, presence: true, if: :quotation?
	validates :client_id, :company_id, :delivery_address_id, presence: true, if: :shipment?
	validates :exchange_rate, presence: true, if: :currency_is_usd?
	
	has_rich_text :description
	has_many :shipments_products, dependent: :destroy
	has_many :products, through: :shipments_products, dependent: :destroy
	
	accepts_nested_attributes_for :shipments_products, allow_destroy: true
	
	enum status: { quotation: 0, order_sale: 1, shipment: 2, sale: 3 }
	enum currency: { mxn: 0, usd: 1 }
	
	def total_kg
		total = 0
		unit_meassure = shipments_products.first.product.unit_meassure
		shipments_products.each do |sp|
			total += sp.quantity * sp.product.weight
		end
		"#{total} <small>#{unit_meassure}</small>"
	end

	def expirated_at
		#issue_at + expirated_days.days
		""
	end

	def subtotal
		sub_total = 0
		shipments_products.map { |product|
			sub_total += (product.quantity.to_i * product.price.to_i) }
		sub_total
	end

	private

	def currency_is_usd?
		currency == Shipment.currencies.keys.second	
	end

	def set_products
		sum = 0
		shipments_products.each { |a| sum+=a.quantity }
		n_products = sum
	end
	
	def set_folio
		return if folio.present?
		
		year =  Time.now.year
		shipments = get_total_shipments(year)
		year = Time.now.year.to_s[2, 2]

		self.folio ||= "FE-#{year}-#{shipments}"
	end
	
	def set_freight_folio
 		return if freight_folio.present?

		self.freight_folio ||= freight.folio
	end

	def set_client_folio
		return if client_folio.present?

		year = Time.now.year
		shipments = get_total_shipments_by_client(year)
		year = Time.now.year.to_s[2, 2]
		code_client = client.code

		self.client_folio ||= "FC-#{year}-#{code_client}-#{shipments}"
	end
	


	def update_shipments(shipments)
		client.update_column(:shipments, shipments)
	end

	def get_total_shipments_by_client(year)
		total_shipments = client.shipments.shipment.where('extract(year from created_at) = ?', year).size
		update_shipments(total_shipments)
		case total_shipments.to_s.size
		when 1
			"000#{total_shipments.to_i + 1 }"
		when 2
		  "00#{total_shipments.to_i + 1 }"
		when 3	
			"0#{total_shipments.to_i + 1 }"
		when 4
			"#{total_shipments.to_i + 1 }"
		end
	end

	def get_total_shipments(year)
		total_shipments = Shipment.shipment.where('extract(year from created_at) = ?', year).size
		case total_shipments.to_s.size
		when 1
			"000#{total_shipments.to_i + 1 }"
		when 2
			"00#{total_shipments.to_i + 1 }"
		when 3	
			"0#{total_shipments.to_i + 1 }"
		when 4
			"#{total_shipments.to_i + 1 }"
		end
	end
end
