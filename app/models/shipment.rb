class Shipment < ApplicationRecord
	before_create :set_products
	before_create :set_folio 
	before_create :set_client_folio 

	belongs_to :company
	belongs_to :client
	belongs_to :delivery_address
	belongs_to :freight
	validates :client_id, :company_id, :delivery_address_id, presence: true

	has_many :shipments_products
	has_many :products, through: :shipments_products
	accepts_nested_attributes_for :shipments_products, allow_destroy: true

	private

	def set_products
		sum = 0
		shipments_products.each { |a| sum+=a.quantity }
		self.n_products = sum
	end

	def set_client_folio
		year =  Time.now.year
		shipments = get_total_shipments_by_client(year)
		year =  Time.now.year.to_s[2, 2]
		code_client = client.code

		self.client_folio = "FC-#{year}-#{code_client}-#{shipments}"
	end

	def set_folio
		year =  Time.now.year
		shipments = get_total_shipments(year)
		year = Time.now.year.to_s[2, 2]
		self.folio = "FE-#{year}-#{shipments}"
	end

	def update_shipments(shipments)
		client.update_column(:shipments, shipments)
	end

	def get_total_shipments_by_client(year)
		total_shipments = client.shipments.where('extract(year from created_at) = ?', year).size
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
		total_shipments = Shipment.where('extract(year from created_at) = ?', year).size
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