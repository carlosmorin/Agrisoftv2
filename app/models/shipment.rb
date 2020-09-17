class Shipment < ApplicationRecord
	require 'action_view'
	include FolioGenerator
	include ActionView::Helpers::DateHelper
  
  default_scope { order(freight_folio: :desc) }
  scope :quotes, -> { where("quote_folio IS NOT NULL") }
  scope :active_quotes, -> { where("quote_folio IS NOT NULL AND CURRENT_TIMESTAMP < issue_at + CAST(CONCAT(expirated_days::text, 'days') AS INTERVAL) AND NOT cancel_quote AND folio IS NULL") }
  scope :expirated_quotes, -> { where("quote_folio IS NOT NULL AND CURRENT_TIMESTAMP > issue_at + CAST(CONCAT(expirated_days::text, 'days') AS INTERVAL) AND folio IS NULL ") }
  scope :canceled_quotes, -> { where("quote_folio IS NOT NULL AND cancel_quote::text = 'true' AND folio IS NULL") }

  scope :order_sales, -> { where("order_sale_folio IS NOT  NULL") }
  scope :active_order_sales, -> { where("order_sale_folio IS NOT NULL AND cancel_sale_order::text = 'false' AND folio IS NULL") }
  scope :active_order_sales_shipments, -> { where("order_sale_folio IS NOT NULL AND folio IS NULL AND cancel_sale_order::text = 'false' AND folio IS NULL") }
  scope :expirated_order_sales, -> {  where("order_sale_folio IS NOT NULL AND appointments.finished_at IS NOT NULL AND CURRENT_TIMESTAMP > appointments.finished_at AND folio IS NULL") }
  scope :canceled_order_sales, -> { where("order_sale_folio IS NOT NULL AND cancel_sale_order::text = 'true' AND folio IS NULL") }

  scope :sales, -> { where("folio IS NOT  NULL") }
  scope :active_sales, -> { where("folio IS NOT NULL AND cancel_sale::text = 'false'") }
  scope :canceled_sales, -> { where("folio IS NOT NULL AND cancel_sale::text = 'true'") }


	before_create :set_products
	before_update :set_products
	before_create :set_folio, if: :sale?
	before_create :set_freight_folio, if: :sale?
	before_create :set_client_folio, if: :sale?
	before_create :set_quote_folio, if: :quotation?
	before_create :set_order_sale_folio, if: :order_sale?
	
	before_update :set_folio, if: :sale?
	before_update :set_freight_folio, if: :sale?
	before_update :set_client_folio, if: :sale?
	before_update :set_order_sale_folio, if: -> { order_sale? && order_sale_folio.nil? }

	belongs_to :company
	belongs_to :client
	belongs_to :delivery_address
	belongs_to :user
	belongs_to :freight, optional: true

	validates :client_id, :issue_at, :company_id, :user_id, :delivery_address_id, :currency, presence: true, if: -> { quotation? }
	validates :client_id, :company_id, :user_id, :delivery_address_id, :currency, presence: true, if: -> { order_sale? }
	
	validates :client_id, :company_id, :delivery_address_id, presence: true, if: :sale?
	validates :exchange_rate, presence: true, if: :currency_is_usd?

	
	has_rich_text :description
	has_many :shipments_products, dependent: :destroy
	has_many :products, through: :shipments_products, dependent: :destroy
	has_many :appointments, inverse_of: :shipment
	accepts_nested_attributes_for :shipments_products, :appointments, allow_destroy: true
	
	enum status: { quotation: 0, order_sale: 1, sale: 2 }
	enum currency: { mxn: 0, usd: 1 }

	def valid_order_sale
		if appointments.any?
			appointment = appointments.first
			return true if appointment.finished_at.nil? || appointment.finished_at.nil?
			Time.zone.now < appointment.finished_at
		else
			return true
		end
	end

	def total_kg
		total = 0
		unit_meassure = shipments_products.first.product.unit_meassure
		shipments_products.each do |sp|
			total += sp.quantity * sp.product.weight
		end
		"#{total} <small>#{unit_meassure}</small>"
	end

	def expirated_at
		if self.issue_at.present?
			self.issue_at + expirated_days.days
		else
			return false if self.appointments.any? 
			self.appointments.finished_at
		end
	end

	def expirated_order_sale
		return false unless appointments.any?
		appointment = self.appointments.first
		appointment. + expirated_days.days
	end

	def subtotal
		sub_total = 0
		shipments_products.map { |product|
			sub_total += (product.quantity * product.price) }
		sub_total
	end

	## Quote
	def valid
		return false unless expirated_at.present?
		Time.zone.now < self.expirated_at
	end

	private

	def currency_is_usd?
		currency == Shipment.currencies.keys.second	
	end

	def set_products
		sum = 0
		shipments_products.each { |a| sum+=a.quantity }
		self.n_products = sum
	end
	
	def set_folio
		return if folio.present?
		
		year = Time.now.year
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
		total_shipments = client.shipments.sales.where('extract(year from created_at) = ?', year).size
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
		total_shipments = Shipment.sales.where('extract(year from created_at) = ?', year).size
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
