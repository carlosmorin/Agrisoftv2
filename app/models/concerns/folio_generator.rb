module FolioGenerator
  extend ActiveSupport::Concern

  def set_quote_folio
		self.quote_folio = generate_quote_folio
	end

	def set_order_sale_folio
		self.order_sale_folio = generate_order_sale_folio
	end

	def generate_quote_folio
		quote_number = Shipment.quotes.size
		quote_number = quote_number + 1 
		case quote_number.to_s.size
		when 1
			"COT-000#{quote_number}"
		when 2
		  "COT-00#{quote_number}"
		when 3	
			"COT-0#{quote_number}"
		when 4
			"COT-#{quote_number}"
		end
	end

	def generate_order_sale_folio
		order_sale_number = Shipment.order_sales.size
		order_sale_number = order_sale_number + 1 
		case order_sale_number.to_s.size
		when 1
			"OV-000#{order_sale_number}"
		when 2
		  "OV-00#{order_sale_number}"
		when 3	
			"OV-0#{order_sale_number}"
		when 4
			"OV-#{order_sale_number}"
		end
	end

end