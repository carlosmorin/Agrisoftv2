module Crm
	class QuotesController < ApplicationController
		before_action :set_object, only: %i[show print]
		add_breadcrumb "CRM", :crm_root_path
		add_breadcrumb "Cotizaciónes", :crm_quotes_path

		def index
			@quotes = Quote.all
		end

		def show
			add_breadcrumb "Detalle"
		end

		def new
			add_breadcrumb "Nueva"
			@quote = Quote.new
			@quote.shipments_products.build
		end

		def create 
			@quote = Quote.new(quote_params)
			if @quote.save
				flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Cotización creada exitosamente"
				redirect_to crm_quote_path(@quote)
			else
				binding.pry
        render :new
			end
		end

	  def print
	    respond_to do |format|
	      format.html
	      format.pdf do
	        render pdf: "Cotización N° #{@quote.folio}",
	        page_size: 'A4',
	        template: "crm/quotes/print.html.slim",
	        layout: "pdf.html",
	        lowquality: true,
	        zoom: 1,
	        dpi: 75
	      end
	    end
	  end

		def quote_params
			params.require(:quote).permit(:client_id, :company_id, :contact_id, 
				:user_id, :expirated_days, :expired_at, :iva, :delivery_address_id, 
				:issue_at, :discount, :description, shipments_products_attributes: [:id, 
					:price, :quantity, :shipment_id, :product_id, :productable_type,
					:productable_id, :unit_meassure, :_destroy])
		end

		private
		def set_object
			id = params[:id].present? ? params[:id] : params[:quote_id]
			@quote = Quote.find(id)
		end
	end
end
