module Crm
	class QuotesController < ApplicationController
		before_action :set_object, only: %i[show print edit update]
		add_breadcrumb "CRM", :crm_root_path
		add_breadcrumb "Cotizaciónes", :crm_quotes_path

		def index
			@quotes = Shipment.quotation.paginate(page: params[:page], per_page: 25)
			search if params[:q].present?
		end

		def show
			add_breadcrumb "Detalle"
			
			if params[:format].present?
				respond_to do |format|
					format.html
					format.xlsx
				 end
			end
		end

		def new
			add_breadcrumb "Nueva"
			@quote = Shipment.new
			@quote.shipments_products.build
		end

		def edit
			add_breadcrumb "Editar"
		end

		def create 
			@quote = Shipment.new(quote_params)
			if @quote.save
				binding.pry
				flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Cotización creada exitosamente"
				redirect_to crm_quote_path(@quote)
			else
				render :new
			end
		end

		def update
			if @quote.update(quote_params)
				flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Cotización actualizada exitosamente"
				redirect_to crm_quote_path(@quote)
			else
				render :edit
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
			params.require(:shipment).permit(:client_id, :company_id, :contact_id,
				:user_id, :expirated_days, :expired_at, :iva, :delivery_address_id,
				:issue_at, :discount, :currency, :exchange_rate, :description, shipments_products_attributes: [:id,
					:price, :quantity, :shipment_id, :product_id, :productable_type,
					:productable_id, :_destroy])
		end

		private

		def search
			q = Regexp.escape(params[:q])
			@quotes = @quotes.where("concat(id) ~* ?", q)
		end

		def set_object
			id = params[:id].present? ? params[:id] : params[:quote_id]
			@quote = Shipment.find(id)
		end
	end
end
