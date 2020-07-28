module Commercial
	class SalesController < ApplicationController
		add_breadcrumb "Commercial", :commercial_root_path
		add_breadcrumb "Ventas", :commercial_sales_path
  	
		def index
			@sales = Shipment.paginate(page: params[:page], per_page: 25)
			@all_sales = Shipment.all

			search if params[:q].present?
			search_by_client if params[:c].present?
		end

		private

		def search
			query = Regexp.escape(params[:q])

			@sales = @sales.where("concat(folio, ' ', client_folio, ' ', 
	      freight_folio, ' ', n_products) ~* ?", query)
	  end
		
		def search_by_client
			client_id = params[:c]
		  
			@sales = @sales.where(client_id: client_id)
		end
  end
end