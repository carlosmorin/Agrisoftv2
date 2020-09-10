module Crm
	class SalesController < ApplicationController
		add_breadcrumb "CRM", :crm_root_path
		add_breadcrumb "Ventas", :crm_sales_path

		def index
			@sales = Shipment.sale
									.order('folio DESC')
                  .joins(products: [:crop, :color, :quality])
                  .includes(products: [:crop, :color, :quality])
									.paginate(page: params[:page], per_page: 25)
			@all_sales = Shipment.sale.all

			search if params[:q].present?
			search_by_client if params[:c].present?
			search_by_crop if params[:crop_id].present?
			search_by_quality if params[:quality_id].present?
			search_by_package if params[:package_id].present?
		end

		private

		def search
			q = Regexp.escape(params[:q])

			@sales = @sales.where("folio ~* ? OR client_folio ~* ? OR freight_folio ~* ? ", q, q, q)

	  end

	  def search_by_crop
      crop_id = params[:crop_id]
      @sales = @sales.where("products.crop_id = ?", crop_id)
    end

    def search_by_quality
      quality_id = params[:quality_id]
      @sales = @sales.where("products.quality_id = ?", quality_id)
    end

    def search_by_package
      package_id = params[:package_id]
      @sales = @sales.where("products.package_id = ?", package_id)
    end
		
		def search_by_client
			client_id = params[:c]
		  
			@sales = @sales.where(client_id: client_id)
		end
  end
end