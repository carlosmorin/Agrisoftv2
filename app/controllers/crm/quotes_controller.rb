module Crm
	class QuotesController < ApplicationController
		add_breadcrumb "CRM", :crm_root_path
		add_breadcrumb "Cotizaciónes", :crm_quotes_path

		def index
			@quotes = Quote.all
		end

		def new
			add_breadcrumb "Nueva"
			@quote = Quote.new
			@quote.shipments_products.build
		end

		def create 
			@quote = Quote.new(quote_params)
			if @quote.save
				flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> 
					Cotización creada exitosamente"
				redirect_to crm_quote_path(@quote)
			else
				binding.pry
        render :new
			end

		end

		def quote_params
			params.require(:quote).permit(:client_id, :company_id, :contact_id, 
				:user_id, :expirated_days, :expired_at, :iva, :delivery_addresses_id, 
				:issue_at, :discount, :description, shipments_products_attributes: [:id, 
					:price, :quantity, :shipment_id, :product_id, :productable_type,
					:productable_id, :_destroy])
		end
	end
end
