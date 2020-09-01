module Crm
	class SalesController < ApplicationController
		add_breadcrumb "CRM", :crm_root_path
		add_breadcrumb "Ventas", :crm_sales_path

		def index
			@sales = Shipment.sale
								.joins(:products)
								.includes(:products)
								.paginate(page: params[:page], per_page: 25)
			@all_sales = Shipment.sale.all

			search if params[:q].present?
			search_by_client if params[:c].present?
		end

		private

		def search
			q = Regexp.escape(params[:q])

			@sales = @sales.where("folio ~* ? OR client_folio ~* ? OR 
				freight_folio ~* ? OR products.name ~* ?", q, q, q, q)

	  end
		
		def search_by_client
			client_id = params[:c]
		  
			@sales = @sales.where(client_id: client_id)
		end
  end
end