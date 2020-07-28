module FolioGenerator
  extend ActiveSupport::Concern

  def set_quote_folio
		self.quote_folio = generate_quote_folio
	end

	def generate_quote_folio
		quote_number = Shipment.where.not(quote_folio: nil).size
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

end