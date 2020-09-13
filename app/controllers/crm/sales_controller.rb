module Crm
	class SalesController < ApplicationController
		add_breadcrumb "CRM", :crm_root_path
		add_breadcrumb "Ventas", :crm_sales_path
		before_action :set_object, only: %i[show cancel]

		def index
			@sales = Shipment.sale.sales if params[:tab] == 'all'
			@sales = Shipment.sale.active_sales if params[:tab] == 'actived'
			@sales = Shipment.sale.canceled_sales if params[:tab] == 'canceled'

			@sales = @sales
								.order('folio DESC')
								.joins(products: [:crop, :color, :quality])
								.includes(products: [:crop, :color, :quality])	
								.paginate(page: params[:page], per_page: 25)
			@all_sales = Shipment.sale.all

			search if params[:q].present?
			search_by_client if params[:c].present?
			advanced_filters if params[:advanced].present? && params[:active_advanced]
		end

    def cancel
      @sale.update(cancel_sale: params[:cancel])
    end

		private

		def advanced_filters
			search_by_crop if params[:advanced][:crop_id].present?
			search_by_quality if params[:advanced][:quality_id].present?
			search_by_package if params[:advanced][:package_id].present?
		end

		def search
			q = Regexp.escape(params[:q])

			@sales = @sales.where("folio ~* ? OR client_folio ~* ? OR freight_folio ~* ? ", q, q, q)

	  end

	  def search_by_crop
      crop_id = params[:advanced][:crop_id]
      @sales = @sales.where("products.crop_id = ?", crop_id)
    end

    def search_by_quality
      quality_id = params[:advanced][:quality_id]
      @sales = @sales.where("products.quality_id = ?", quality_id)
    end

    def search_by_package
      package_id = params[:advanced][:package_id]
      @sales = @sales.where("products.package_id = ?", package_id)
    end
		
		def search_by_client
			client_id = params[:c]
		  
			@sales = @sales.where(client_id: client_id)
		end

    def set_object
      id = params[:id].present? ? params[:id] : params[:sale_id]
      @sale = Shipment.find(id)
    end
  end
end